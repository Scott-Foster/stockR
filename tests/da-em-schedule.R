# The DA.EM cooling schedule should reach the uncooled likelihood surface at
# EM.minit, not several iterations earlier.
nu0 <- 1e-4
n_steps <- 25L
eta <- stockR:::find.eta.for.DA(nu0, n_steps)

nu <- numeric(n_steps + 1L)
nu[1L] <- nu0
for (i in seq_len(n_steps)) {
  nu[i + 1L] <- stockR:::update.nu.for.DA(nu[i], eta)
}

stopifnot(
  all(nu[-length(nu)] < 1),
  isTRUE(all.equal(unname(nu[length(nu)]), 1, tolerance = 1e-12)),
  all(diff(nu) > 0)
)
