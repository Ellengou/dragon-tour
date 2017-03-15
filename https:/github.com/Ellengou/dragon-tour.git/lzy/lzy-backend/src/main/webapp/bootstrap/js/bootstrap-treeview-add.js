function checkAllParent(data) {
    if (data.parentId != null) {
        $('#tree').treeview('checkNode', [ data.parentId, { silent: true } ]);
        checkAllParent($('#tree').treeview('getNode', data.parentId));
    }
}

function unCheckAllChild(data) {
    if (data.nodes) {
        for (var i = 0; i < data.nodes.length; i++) {
            $('#tree').treeview('uncheckNode', [data.nodes[i].nodeId, {silent: true}]);
            unCheckAllChild(data.nodes[i]);
        }
    }
}