test_that("multiplication works", {
  set.seed(12345)
  data=matrix(rnorm(700),100,7)
  colnames(data)=c("y","x1","x2","x3","x4","x5","x6")
  data=data.frame(data)
  lm1=lm(y~x1,data=data)
  lm2=lm(y~.,data=data)
  expect_equal(selection(lm1,lm2,direction="forward",trace=1)$coefficients,
               step(lm1,direction="forward",scope=formula(lm2))$coefficients)
  expect_equal(selection(lm2,lm2,direction="backward",trace=1)$coefficients,
               step(lm2,direction="backward",scope=formula(lm2))$coefficients)
})
