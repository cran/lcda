\name{predict.cclcda2}
\alias{predict.cclcda2}
\encoding{UTF-8}
\title{Predict method for Common Components Latent Class Discriminant Analysis 2 (CCLCDA2)}
\description{Classifies new observations using parameters determined by
the \code{cclcda2}-function.
}
\usage{
\method{predict}{cclcda2}(object, newdata, ...)
}
\arguments{
  \item{object}{Object of class \code{cclcda2}.}
  \item{newdata}{Data frame of cases to be classified.}
  \item{\dots}{Further arguments are ignored.}
}
\details{Posterior probabilities for new observations using parameters determined by
the \code{cclcda2}-function are computed. The classification of the new data is done by the Bayes decision function.
}
\value{A list with components:
\item{class}{Vector (of class \code{factor}) of classifications.}
\item{posterior}{Posterior probabilities for the classes. 
    For details of computation see \code{\link{cclcda2}}.}
}
\author{ Michael B\"ucker}
\seealso{ \code{\link{cclcda2}}, \code{\link{lcda}}, \code{\link{predict.lcda}}, \code{\link{cclcda}}, \code{\link{predict.cclcda}}, \code{\link[poLCA]{poLCA}} }
\examples{
# response probabilites
probs1 <- list()

probs1[[1]] <- matrix(c(0.7,0.1,0.1,0.1,0.1,0.7,0.1,0.1,
                        0.1,0.1,0.7,0.1,0.1,0.1,0.1,0.7), 
                      nrow=4, byrow=TRUE)
probs1[[2]] <- matrix(c(0.1,0.7,0.1,0.1,0.1,0.1,0.7,0.1,
                        0.1,0.1,0.1,0.7,0.7,0.1,0.1,0.1),
                      nrow=4, byrow=TRUE)
probs1[[3]] <- matrix(c(0.1,0.1,0.7,0.1,0.1,0.1,0.1,0.7,
                        0.7,0.1,0.1,0.1,0.1,0.7,0.1,0.1),
                      nrow=4, byrow=TRUE)
probs1[[4]] <- matrix(c(0.1,0.1,0.1,0.7,0.7,0.1,0.1,0.1,
                        0.1,0.7,0.1,0.1,0.1,0.1,0.7,0.1),
                      nrow=4, byrow=TRUE)

prior <- c(0.5,0.5)
wmk <- matrix(c(0.45,0.45,0.05,0.05,0.05,0.05,0.45,0.45),
              ncol=4, nrow=2, byrow=TRUE)
wkm <- apply(wmk*prior, 2, function(x) x/sum(x))

# generation of training data
data_temp <- poLCA.simdata(N = 1000, probs = probs1,
                           nclass = 2, ndv = 4, nresp = 4,
                           P=rep(0.25,4))
data <- data_temp$dat
lclass <- data_temp$trueclass
grouping <- numeric()
for (i in 1:length(lclass))
{
grouping[i] <- sample(c(1,2),1, prob=wkm[,lclass[i]])
}

# generation of test data
data_temp <- poLCA.simdata(N = 500, probs = probs1,
                           nclass = 2, ndv = 4, nresp = 4,
                           P=rep(0.25,4))
data.test <- data_temp$dat
lclass <- data_temp$trueclass
grouping.test <- numeric()
for (i in 1:length(lclass))
{
grouping.test[i] <- sample(c(1,2),1, prob=wkm[,lclass[i]])
}

# cclcda2-procedure
object <- cclcda2(data, grouping, m=4)
pred <- predict(object, data.test)$class
1-(sum(pred==grouping.test)/500)
}
\keyword{multivariate}
\keyword{classif}
