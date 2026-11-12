# Former names of three exported functions, kept working for one release cycle.
#
# Until version 0.99.8 these functions had snake_case names. Published work
# cites three of those names, so they still run: each one re-issues the
# caller's own call under the new name, evaluated where the caller wrote it.
# The arguments therefore reach the new function exactly as written, and a
# function that records its call (mgccaAudit(), mgccaSelectLambda()) records
# the same call it would have recorded had the new name been used.

.mgcca_forward <- function(fun, name, call, frame) {
    env <- new.env(parent = frame)
    assign(name, fun, envir = env)
    call[[1L]] <- as.name(name)
    eval(call, env)
}

#' @rdname mgccaLoad
#' @param ... For \code{mgcca_load()} only: the arguments of
#'   \code{mgccaLoad()}, passed on unchanged.
#' @section Former name:
#'   \code{mgcca_load()} is the name this function had before version 0.99.8.
#'   It still works, without a warning, so that code and published analyses
#'   that call it keep running: it passes its arguments to \code{mgccaLoad()}
#'   unchanged and returns the same result. It will be removed in a later
#'   release; new code should call \code{mgccaLoad()}.
#' @export
mgcca_load <- function(...)
    .mgcca_forward(mgccaLoad, "mgccaLoad", sys.call(), parent.frame())

#' @rdname mgccaAudit
#' @section Former name:
#'   \code{mgcca_audit()} is the name this function had before version 0.99.8.
#'   It still works, without a warning, so that code and published analyses
#'   that call it keep running: it passes its arguments to \code{mgccaAudit()}
#'   unchanged and returns the same result. It will be removed in a later
#'   release; new code should call \code{mgccaAudit()}.
#' @export
mgcca_audit <- function(...)
    .mgcca_forward(mgccaAudit, "mgccaAudit", sys.call(), parent.frame())

#' @rdname mgccaSelectLambda
#' @param ... For \code{mgcca_select_lambda()} only: the arguments of
#'   \code{mgccaSelectLambda()}, passed on unchanged.
#' @section Former name:
#'   \code{mgcca_select_lambda()} is the name this function had before version
#'   0.99.8. It still works, without a warning, so that code and published
#'   analyses that call it keep running: it passes its arguments to
#'   \code{mgccaSelectLambda()} unchanged and returns the same result. It will
#'   be removed in a later release; new code should call
#'   \code{mgccaSelectLambda()}.
#' @export
mgcca_select_lambda <- function(...)
    .mgcca_forward(mgccaSelectLambda, "mgccaSelectLambda", sys.call(),
                   parent.frame())
