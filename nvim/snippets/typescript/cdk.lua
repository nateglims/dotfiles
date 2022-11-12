return {
  s("stk",
    fmt([[
    export class <> extends DeploymentStack {
      constructor(parent: cdk.App, name: string, props: <>) \{
        super();
        <>
      }
    }
    ]], {i(1, "stack"), i(2, "props"), i(3)}, { delimiters = "<>"}
    )),
}
