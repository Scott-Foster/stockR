\name{calcFst}
\alias{calcFst}
\title{Calculate Fst statistics for frequency data}
\description{Calculates Weir and Cockerham's Fst for frequency data
}
\usage{
calcFst(data, grps)
}
\arguments{
You can put normal text in \bold{Arguments}, too, like this. Remember to indent all arguments, as below.
\item{ data}{a numeric marker-by-individual matrix of diploid allele dosages. For individual i and codominant marker j, \code{data[j, i]} is 0, 1, or 2. Missing genotypes must be represented by \code{NA}.}
\item{ grps}{a vector giving one non-missing population label for each individual. Numeric, character, and factor labels are accepted.}
}
\value{A numeric matrix containing the pairwise Fst values between all populations.
}
\details{This function is a wrapper for the \code{Fstat()} function taken from the archived Geneland package. Population labels are converted internally to contiguous integer codes. Missing diploid genotypes are preserved as missing for the native estimator; they are not treated as an additional allele.
}
\section{Authors}{Arnaud Estoup for original code in Turbo Pascal. Translation in Fortran and interface with R{} by Gilles Guillot (for Geneland package). Scott Foster for latest wrapper for stockR package.
}
\examples{
set.seed(717)
data <- sim.stock.data( nAnimals=50, nSNPs=500, nSampleGrps=50, K=5, ninform=50)
calcFst( data, attributes( data)$grps)
}
\keyword{misc}
\author{Scott D. Foster}
