## ------------------------------------------------------------------------
VerdubbelDit <- function(x) {
  if (!is.numeric(x)) {
      stop("No string-based input allowed!")
  }
  n <- x*2
  n
}
plot(VerdubbelDit, xlim = c(-100,100), ylim = c(-200, 200))

## ------------------------------------------------------------------------
VerdubbelDit(20)
VerdubbelDit(-10)
tryCatch(
  VerdubbelDit("hallo"),
  error = function(x) { print("hallo is invalid input indeed") }
)


