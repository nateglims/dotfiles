return {
    s({trig="con", dscr="A CDK Construct"},
      fmta(
      [[
        import * as cdk from 'aws-cdk-lib';
        import { Construct } from 'constructs';

        /**
         * ...
         */
        export <>Props interface {
            /** */
        }
        /**
         * ...
         */
        export class <> extends Construct {
            constructor(scope: Construct, id: string, props: <>Props = {}) {
                super(scope, id);
                <>
            }
        }
      ]],
      {
        i(1),
        rep(1),
        rep(1),
        i(2),
      })
    ),
    s({trig="stk", dscr="A CDK Stack"},
      fmta(
      [[
        import * as cdk from 'aws-cdk-lib';
        import { Construct } from 'constructs';

        /**
         * ...
         */
        export <>Props interface extends cdk.StackProps {
            /** */
        }
        /**
         * ...
         */
        export class <> extends cdk.Stack {
            constructor(scope: Construct, id: string, props: <>Props) {
                super(scope, id, props);
                <>
            }
        }
      ]],
      {
        i(1),
        rep(1),
        rep(1),
        i(2),
      })
    ),
}
