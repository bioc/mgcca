# The three former names kept for one release cycle return exactly what the new
# names return, call record included.

h5_cleanup_on_exit()

alias_tables <- function() {
    set.seed(8)
    ids <- sprintf("id%02d", seq_len(30L))
    a <- matrix(stats::rnorm(30L * 4L), 30L, 4L,
                dimnames = list(ids, paste0("a", 1:4)))
    b <- matrix(stats::rnorm(24L * 3L), 24L, 3L,
                dimnames = list(ids[4:27], paste0("b", 1:3)))
    list(a = a, b = b)
}

test_that("mgcca_load() returns what mgccaLoad() returns", {
    h5 <- h5_tmp()
    suppressMessages(mgcca(alias_tables(), filename = h5, nfac = 2,
                           method = "solve", collect = FALSE))
    BigDataStatMeth::hdf5_close_all()
    expect_identical(mgcca_load(h5), mgccaLoad(h5))
})

test_that("mgcca_audit() returns what mgccaAudit() returns", {
    av <- cbind(one = rep(c(TRUE, FALSE), c(40, 60)),
                two = rep(TRUE, 100),
                three = rep(c(FALSE, TRUE), c(40, 60)))
    expect_identical(mgcca_audit(av, L = 2), mgccaAudit(av, L = 2))
    # arguments that arrive through another function's dots are passed on too
    through <- function(...) mgcca_audit(...)
    a <- through(av, L = 2)
    b <- mgccaAudit(av, L = 2)
    a$call <- b$call <- NULL
    expect_identical(a, b)
})

test_that("mgcca_select_lambda() returns what mgccaSelectLambda() returns", {
    tabs <- alias_tables()
    a <- suppressWarnings(mgcca_select_lambda(tabs, nfac = 2,
                                              gamma = c(0.1, 1), K = 3,
                                              seed = 1))
    b <- suppressWarnings(mgccaSelectLambda(tabs, nfac = 2, gamma = c(0.1, 1),
                                            K = 3, seed = 1))
    expect_identical(a, b)
})
