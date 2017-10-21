component accessors=true output=false persistent=false {

    property name="maxOperations" type="numeric" default="100";
    property name="timer" type="component";

    public Testable function init() {
        variables.timer = new stress.core.Timer();
        return this;
    }

    public Testable function beforeTests() {
        return this;
    }

    public Testable function run() {
        this.beforeTests();
        variables.timer.start();

        for (var local.incr = 1; local.incr <= variables.maxOperations; local.incr++) {
            this.execute();
            variables.timer.step('Code execution N°' & local.incr);

        }

        this.afterTests();
        return this;
    }

    public any function execute() {}

    public Testable function afterTests() {
        return this;
    }

    public string function getCode() {
        return createUUID();
    }

    public string function getTestName() {
        return getMetadata(this).fullName;
    }

    public struct function getDatas(boolean withDetails = false) {
        return {'code': getCode(), 'name': getTestName(), 'type': 'test', 'results': variables.timer.getDatas(arguments.withDetails)};
    }

	public struct function getDetailedDatas() {
		return getDatas(true);
	}

	public Testable function printResults() {
        var local.datas = getDatas();

        writeOutput( local.datas.name & ' | ' );
		writeOutput( 'Executing ' & local.datas.results.count & ' ' &
				'times code : ' & local.datas.results.min & ' µs min / ' &
				local.datas.results.avg & ' µs avg / ' &
				local.datas.results.max & ' µs max / ' &
				local.datas.results.total & ' µs total' );
        writeOutput('<br/>');

        return this;
	}


}
