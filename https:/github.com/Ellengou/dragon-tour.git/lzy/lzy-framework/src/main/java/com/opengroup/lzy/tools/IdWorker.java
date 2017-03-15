package com.opengroup.lzy.tools;

/**
 * ID生成器
 * 
 * @author lc
 *
 * @date 2017年1月2日 上午11:01:24
 */
public class IdWorker {

	private static IdWorker idWorker;

	private long workerId;
	private long serverType;
	private long sequence = 0L;

	private long twepoch = 1475251200000L;// 起始时间：2016.10.01 00:00:00

	private long workerIdBits = 4L;// 机器编号，最多支持16台机器
	private long serverTypeBits = 2;// 服务类型位数 ：前台、后台、app端等
	private long sequenceBits = 9L;// 1毫秒内产生最大个数,最多512个
	private long maxWorkerId = -1L ^ (-1L << workerIdBits);
	private long maxServerType = -1L ^ (-1L << serverTypeBits);
	private long workerIdShift = sequenceBits;
	private long serverTypeShift = workerIdShift + serverTypeBits;
	private long timestampLeftShift = serverTypeShift + workerIdBits;
	private long sequenceMask = -1L ^ (-1L << sequenceBits);

	private long lastTimestamp = -1L;

	private IdWorker(long workerId, long serverType) {
		// 检查机器编号是否超出最大值
		if (workerId > maxWorkerId || workerId < 0) {
			throw new IllegalArgumentException(String.format(
					"机器编号不能大于%d并且不能小于 0", maxWorkerId));
		}
		if (serverType > maxServerType || serverType < 0) {
			throw new IllegalArgumentException(String.format(
					"服务类型不能大于%d并且不能小于0", maxServerType));
		}
		this.workerId = workerId;
		this.serverType = serverType;
		this.idWorker = this;
	}

	public static long getId() {
		return idWorker.nextId();
	}

	private synchronized long nextId() {
		long timestamp = timeGen();

		if (timestamp < lastTimestamp) {
			throw new RuntimeException(
					String.format(
							"Clock moved backwards.  Refusing to generate id for %d milliseconds",
							lastTimestamp - timestamp));
		}

		if (lastTimestamp == timestamp) {
			sequence = (sequence + 1) & sequenceMask;
			if (sequence == 0) {
				timestamp = tilNextMillis(lastTimestamp);
			}
		} else {
			sequence = 0L;
		}

		lastTimestamp = timestamp;

		return ((timestamp - twepoch) << timestampLeftShift)
				| (serverType << serverTypeShift) | (workerId << workerIdShift)
				| sequence;
	}

	protected long tilNextMillis(long lastTimestamp) {
		long timestamp = timeGen();
		while (timestamp <= lastTimestamp) {
			timestamp = timeGen();
		}
		return timestamp;
	}

	private long timeGen() {
		return System.currentTimeMillis();
	}

	public static void main(String[] args) {
		// IdWorker worker = new IdWorker(1, 1);
		// System.out.println(worker.nextId());
		// Date stringToDate = DateUtil.StringToDate("2016-10-01 00:00:00",
		// DateStyle.YYYY_MM_DD_HH_MM_SS);
		// System.out.println(stringToDate.getTime());
	}
}