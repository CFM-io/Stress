component extends="stress.core.Testable" accessors=true output=false persistent=false {

    property name="numberOfKeys" type="numeric" default="100000";
    property name="structToTest" type="struct";
    property name="existingKey" type="string";
    property name="nonExistingKey" type="string";

    public StructKeyExistsTest function init(numeric maxOperations = 100000, numeric numberOfKeys = 100000) {
        super.init();
        variables.maxOperations = arguments.maxOperations;
        variables.numberOfKeys = arguments.numberOfKeys;
        return this;
    }

    public string function getTestName() {
        return super.getTestName() & ' (' & variables.numberOfKeys & ' keys / ' & variables.maxOperations & ' samples)';
    }

    public StructKeyExistsTest function beforeTests() {
        variables.structToTest = {};
        for (var local.i = 1; i < variables.numberOfKeys; ++local.i) {
            variables.existingKey = createUUID();
            variabes.structToTest[variables.existingKey] = createUUID();

        }

        variables.nonExistingKey = createUUID();
        return this;
    }

    public boolean function execute() {
        return (structKeyExists(variables.structToTest, variables.existingKey));
    }


}
