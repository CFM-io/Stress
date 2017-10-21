component accessors=true output=false persistent=false {

    property name="output" type="string";

    public TableResults function init() {
        return this;
    }

    public TableResults function beforeProcess() {
        return this;
    }

    public any function processDatas(required struct datas, boolean isSubDatas = false) {
        // header name="Content-Type" value="application/json";
        // writeOutput(serializeJSON(arguments.datas));
        // return this;
        var local.out  = '';

        if (!arguments.isSubDatas) {
            local.out &= '<table>';
            local.out &= '<tr><th>Type / Name</th><th>Tests</th><th>Min</th><th>Avg</th><th>Max</th></tr>';

        }

        local.out &= '<tr id="' &  arguments.datas.code & '"><td>' & uCase(arguments.datas.type) & ' / ' & arguments.datas.name & '</td>';
        local.out &= '<td>' & arguments.datas.results.count & '</td>';
        local.out &= '<td>' & arguments.datas.results.min & '</td>';
        local.out &= '<td>' & arguments.datas.results.avg & '</td>';
        local.out &= '<td>' & arguments.datas.results.max & '</td></tr>';

        if (structKeyExists(arguments.datas, 'childs')) {
            local.out &= '<tr style="padding-top: 10px;"><th>Type / Name</th><th>Sample</th><th>Min</th><th>Avg</th><th>Max</th></tr>';

            for (var local.i = 1; local.i <= arrayLen(arguments.datas.childs); ++i) {
                local.out &= processDatas(arguments.datas.childs[i], true);
            }

        }

        if (!arguments.isSubDatas) {
            local.out &= '</table>';
        }

        variables.output = local.out;
        return local.out;

    }

    public TableResults function afterProcess() {
        writeOutput(variables.output);
        return this;
    }

}
