package com.opengroup.lzy.core.utils;


import com.opengroup.lzy.core.utils.comparator.MapComparator;

import java.util.*;


/**
 * List的处理工具类
 *
 * @author Wesley
 */
public class ListUtils extends org.apache.commons.collections.ListUtils {

    private ListUtils() {
    }

    /**
     * 返回一个用逗号分开的字符串
     *
     * @return 1, 2, 3
     */
    public static <T> String toSimpleString(List<T> list) {
        return ArrayUtils.toSimpleString(list.toArray());
    }

    /**
     * String org.apache.commons.lang.ArrayUtils.toString(Object array)
     * <p>
     * <p>
     * <p>
     * Outputs an array as a String, treating null as an empty array.
     * <p>
     * Multi-dimensional arrays are handled correctly, including
     * multi-dimensional primitive arrays.
     * <p>
     * The format is that of Java source code, for example {a,b}.
     * <p>
     * Parameters: array the array to get a toString for, may be null Returns: a
     * String representation of the array, '{}' if null array input
     */
    public static <T> String toString(List<T> list) {
        return ArrayUtils.toString(list);
    }

    /**
     * String org.apache.commons.lang.ArrayUtils.toString(Object array, String
     * stringIfNull)
     * <p>
     * <p>
     * <p>
     * Outputs an array as a String handling nulls.
     * <p>
     * Multi-dimensional arrays are handled correctly, including
     * multi-dimensional primitive arrays.
     * <p>
     * The format is that of Java source code, for example {a,b}.
     * <p>
     * Parameters: array the array to get a toString for, may be null
     * stringIfNull the String to return if the array is null Returns: a String
     * representation of the array
     */
    public static <T> String toString(List<T> list, String stringIfNull) {
        return ArrayUtils.toString(list, stringIfNull);
    }

    /**
     * 新建一个ArrayList
     *
     * @return
     */
    public static <E> ArrayList<E> newArrayList() {
        return new ArrayList<E>();
    }

    /**
     * 通过一个泛型接口初始化一个ArrayList
     *
     * @param list
     * @return
     */
    public static <E> ArrayList<E> newArrayList(List<E> list) {
        return new ArrayList<E>();
    }

    /**
     * 如果为空则简历一个新的ArrayList
     *
     * @param list
     * @return
     */
    public static <E> ArrayList<E> newArrayListIfNull(List<E> list) {
        return list == null ? new ArrayList<E>() : ObjectUtils.softCast(list, new ArrayList<E>());
    }

    /**
     * 通过数组建立一个ArrayList
     *
     * @param elements
     * @return
     */
    public static <E> ArrayList<E> newArrayList(E... elements) {
        ArrayList<E> list = new ArrayList<E>(ArrayUtils.getLength(elements));
        CollectionUtils.addAll(list, elements);
        return list;
    }

    /**
     * 对List<Map<String, Object>> resultList 按照Map中的key进行降序排序，
     *
     * @param key 排序字段名称
     *            排序方式：DESC 降序，ASC 升序 ；(默认升序)
     * @throws Exception
     */
    public static <K, V> void sort(List<Map<K, V>> list, final K key, final String sort) {
        try {
            Collections.sort(list, new MapComparator<Map<K, V>>(key, sort));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println(newArrayList("12312"));
        Map<String, Object> map1 = new HashMap<String, Object>();
        Map<String, Object> map2 = new HashMap<String, Object>();
        Map<String, Object> map3 = new HashMap<String, Object>();
        map1.put("name", 12d);
        map2.put("name", 10d);
        map3.put("name", 11d);
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list.add(map1);
        list.add(map2);
        list.add(map3);
        sort(list, "name", MapComparator.ASC);
        System.out.println(list.get(0).get("name"));
    }

}
