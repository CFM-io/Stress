<cfscript>
    st = new stress.core.Suitable()
        .addTest(new stress.tests.StructKeyExistsTest(10000, 500))
        .addTest(new stress.tests.IsDefinedTest(10000, 500))
        .addTest(new stress.tests.StructKeyExistsTest())
        .addTest(new stress.tests.IsDefinedTest())
        .run();

</cfscript>
