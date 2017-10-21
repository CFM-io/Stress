component extends="stress.tests.StructKeyExistsTest" accessors=true output=false persistent=false {

    public boolean function execute() {
        return (isDefined('variables.structToTest[' & variables.existingKey & ']' ));
    }


}
