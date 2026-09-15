# calcFst() must preserve missing diploid genotypes and must not depend on the
# external representation of population labels.
x <- rbind(
  c(0, 1, 2, 0, 1, 2),
  c(2, 2, 1, 0, 0, 1),
  c(0, 0, 1, 1, 2, 2)
)
groups <- rep(1:2, each = 3)

numeric_result <- stockR::calcFst(x, groups)
stopifnot(
  isTRUE(all.equal(stockR::calcFst(x, groups * 10), numeric_result)),
  isTRUE(all.equal(stockR::calcFst(x, ifelse(groups == 1, "A", "B")),
                   numeric_result))
)

# Construct the allele-pair representation independently while retaining NA.
x_missing <- x
x_missing[1, 1] <- NA_real_
alleles <- matrix(NA_real_, nrow = ncol(x_missing),
                  ncol = 2L * nrow(x_missing))
for (marker in seq_len(nrow(x_missing))) {
  dosage <- x_missing[marker, ]
  alleles[, 2L * marker - 1L] <- ifelse(
    is.na(dosage), NA_real_, as.numeric(dosage > 0)
  )
  alleles[, 2L * marker] <- ifelse(
    is.na(dosage), NA_real_, as.numeric(dosage == 2)
  )
}

expected <- suppressWarnings(stockR:::Fstat(alleles, 2L, groups)$Fst)
observed <- suppressWarnings(stockR::calcFst(x_missing, groups))
stopifnot(isTRUE(all.equal(observed, expected)))

stopifnot(
  inherits(try(stockR::calcFst(x + 3, groups), silent = TRUE), "try-error"),
  inherits(try(stockR::calcFst(x, groups[1:2]), silent = TRUE), "try-error"),
  inherits(try(stockR::calcFst(x, c(groups[-1], NA)), silent = TRUE), "try-error")
)
