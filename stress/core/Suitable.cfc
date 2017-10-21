component accessors=true output=false persistent=false {

    property name="test" type="array";
    property name="results" type="struct";
    property name="timer" type="component";
    property name="withDetails" type="boolean";

    property name="dataProcessor" type="component";

    public Suitable function init() {
        variables.dataProcessor = new stress.out.TableResults();
        variables.timer = new stress.core.Timer();
        variables.tests = arrayNew(1);
        variables.withDetails = false;
        return this;
    }

    public Suitable function addTest(required stress.core.Testable test) {
        arrayAppend(variables.tests, arguments.test);
        return this;
    }

    public Suitable function beforeRun() {
        return this;
    }

    public Suitable function run() {
        beforeRun();
        variables.timer.start();

        for (var local.t in variables.tests) {
            if (isInstanceOf(local.t, 'stress.core.Testable')) {
                local.t.run();
                variables.timer.step('Testing ' &  local.t.getTestName());
                variables.results[local.t.getCode()] = local.t.getDatas(variables.withDetails);
            }
        }
        afterRun();

        variables.dataProcessor.beforeProcess();
        variables.dataProcessor.processDatas(getDatas());
        variables.dataProcessor.afterProcess();

        return this;
    }

    public Suitable function afterRun() {
        return this;
    }

    public string function getCode() {
        return createUUID();
    }

    public string function getSuiteName() {
        return getMetadata(this).fullName;
    }

	public struct function getDatas(boolean withDetails = false) {
        var local.datas = {'code': getCode(), 'name': getSuiteName(), 'type': 'suite', 'childs': []};
        local.datas.results = variables.timer.getDatas(arguments.withDetails);

        for (var local.t in variables.tests) {
            if (isInstanceOf(local.t, 'stress.core.Testable')) {
                local.datas.childs.append(local.t.getDatas(arguments.withDetails));
            }
        }

        return local.datas;
	}

	public Suitable function printResults() {
        for (var local.t in variables.tests) {
            if (isInstanceOf(local.t, 'stress.core.Testable')) {
                local.t.printResults();
            }
        }

        return this;
	}

}
