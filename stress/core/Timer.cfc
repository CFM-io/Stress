component accessors=true {

	property name="initialTick";
	property name="details" type="array";
	property name="times" type="array";

	property name="min" type="numeric";
	property name="max" type="numeric";
	property name="total" type="numeric";
	property name="count" type="numeric";

	public Timer function init() {
		start();
		return this;
	}

	public Timer function start() {
		variables.initialTick = 0;
		variables.details = [];
		variables.times = [];

		variables.previous = 0;
		variables.min = 999999;
		variables.max = 0;
		variables.total = 0;
		variables.count = 0;

		variables.initialTick = getTickCount();
		variables.previous = variables.initialTick;
		return this;
	}

	public Timer function step(string label = '') {
		var local.tick = getTickCount();
		var local.elapsed = local.tick - variables.previous;

		variables.details.append({elapsed: local.elapsed, label: arguments.label});
		variables.times.append(local.elapsed);

		(local.elapsed > variables.max) ? variables.max = local.elapsed : '';
		(local.elapsed < variables.min) ? variables.min = local.elapsed : '';
		variables.total += local.elapsed;
		++variables.count;

		variables.previous = getTickCount();

		return this;
	}

	public numeric function getAverage() {
		return (variables.total / variables.count);
	}

	public struct function getDatas(boolean withDetails = false) {
		var local.datas = {'count': variables.count, 'total': variables.total,
			'min': variables.min, 'avg': getAverage(), 'max': variables.max};

		if (arguments.withDetails) {
			local.datas.details = variables.details;
		}

		return local.datas;
	}

	public struct function getDetailedDatas() {
		return getDatas(true);
	}

}
