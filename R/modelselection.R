#This function is used for backward or forward selection for linear regression
selection=function(startm, endm,direction="forward",trace=1){
  library(stats)
  mydata1=startm$model
  mydata2=endm$model
  y_name=colnames(mydata1)[1]
  colnames(mydata1)[1]='y'
  colnames(mydata2)[1]='y'
  startname=colnames(mydata1)
  endname=colnames(mydata2)

  #forward selection
  if (direction=="forward"){
    subtractname=endname[which(!endname %in% startname)]
    tempname=c()
    while (TRUE){
      LMsum = matrix(0,nrow = length(subtractname)+1, ncol = 4)
      #Degree of freedom of each variables in model for this step
      for (i in 1:length(subtractname)){
        if (class(mydata2[,subtractname[i]]) == "factor"){
          LMsum[i,1]=length(levels(mydata2[,subtractname[i]]))-1
        }
        else{
          LMsum[i,1]=1
        }
        #Linear regression when add this variable
        fit=lm(y~.,data=mydata2[,c(startname,tempname,subtractname[i])])
        ano=anova(fit)
        #Regression sum of squares when add this variable
        LMsum[i,2]=ano[subtractname[i],"Sum Sq"]
        #Error sum of squares when add this variable
        LMsum[i,3]=ano["Residuals","Sum Sq"]
        #AIC when add this variable
        LMsum[i,4]=extractAIC(fit)[2]
      }

      data_temp=cbind(mydata1,mydata2[,tempname])
      #Linear regression of initial model
      fit_ori=lm(y~.,data=data_temp)
      ano_ori=anova(fit_ori)
      #Error sum of squares and AIC for initial model
      LMsum[length(subtractname)+1,3]= ano_ori["Residuals","Sum Sq"]
      LMsum[length(subtractname)+1,4]=extractAIC(fit_ori)[2]
      colnames(LMsum)=c("Df","Sum of Sq","Rss","AIC")
      rownames(LMsum)=c(subtractname,"None")
      LMsum=LMsum[order(LMsum[,4],decreasing=F),]

      selectname=rownames(LMsum)[1]#
      if (trace>0) {
        cat("Start: AIC=",LMsum["None",4],"\n")
        print(LMsum)
      }
      #stop when the AIC of initial model is minimum
      if (selectname!="None"){
        tempname=c(tempname,selectname)
        subtractname=subtractname[-which(subtractname==selectname)]
      }
      else{
        break
      }
    }
  }

  #backward selection
  if (direction=="backward"){
    endname=c(y_name)
    tempname=c()
    subtractname=startname[which(!startname %in% endname)]

    while (TRUE){
      if (length(subtractname)==0) break
      LMsum = matrix(0,nrow = length(subtractname)+1, ncol = 4)

      data_temp=mydata2[,c(endname,subtractname)]#
      fit_ori=lm(y~.,data=data_temp)#
      ano_ori=anova(fit_ori)#
      LMsum[length(subtractname)+1,3]= ano_ori["Residuals","Sum Sq"]#
      LMsum[length(subtractname)+1,4]=extractAIC(fit_ori)[2]#
      colnames(LMsum)=c("Df","Sum of Sq","Rss","AIC")#
      rownames(LMsum)=c(subtractname,"None")#

      #Degree of freedom of each variables in model for this step
      for (i in 1:length(subtractname)){
        if (class(mydata2[,subtractname[i]]) == "factor"){
          LMsum[i,1]=length(levels(mydata2[,subtractname[i]]))-1#
        }
        else{
          LMsum[i,1]=1
        }
        if (length(subtractname)>1){
          fit=lm(y~.,data=mydata2[,c(endname,subtractname[-i])])
        }else{
          data_temp=data.frame(matrix(mydata2[,endname],ncol=1))
          colnames(data_temp)="y"
          fit=lm(y~.,data=data_temp)
        }
        ano=anova(fit)
        #Error sum of squares when delete this variable
        LMsum[i,3]=ano["Residuals","Sum Sq"]#
        LMsum[i,2]=LMsum[i,3]-LMsum[length(subtractname)+1,3]
        #AIC when delete this variable
        LMsum[i,4]=extractAIC(fit)[2]
      }

      LMsum=LMsum[order(LMsum[,4],decreasing=F),]

      selectname=rownames(LMsum)[1]
      if (trace>0) {
        cat("Start: AIC=",LMsum["None",4],"\n")
        print(LMsum)
      }
      #stop when the AIC of model which did't delete anything is minimum
      if (selectname!="None"){
        tempname=c(tempname,selectname)
        subtractname=subtractname[-which(subtractname==selectname)]
      }
      else{
        break
      }
    }
  }

}
