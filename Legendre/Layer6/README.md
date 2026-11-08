# Layer 6 — certified finite verification

Reserved for future certificate generation/checking and finite Legendre or
Oppermann verification. No large published computation is certified here yet.
The current specifications and the verified Oppermann-to-Legendre bridge are
in `Legendre/Literature/`. Keep future implementations in this directory and
create/export a `Legendre.Layer6` public entry point when there is Lean content.

Preserve the square-index range separately from a prime-search bound. Document
certificate soundness and distinguish correctness from heuristic runtime claims.
