return ({
  s('bs', fmta([[
version: 0.2
phases:
  pre_build:
    commands:
      - <>
  build:
    commands:
      - echo Build started on `date`
      - <>
  post_build:
    commands:
      - echo Build completed on `date`
      - <>
      ]],
    {
      i(1),
      i(2),
      i(3),
    })
  ),
})
