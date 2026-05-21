FROM ocaml/opam:debian-12-ocaml-5.1
WORKDIR /app

USER root
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    pkg-config

COPY . .
RUN chown -R opam:opam /app

USER opam
RUN opam update && opam install dune yojson lwt mysql --yes
RUN eval $(opam env) && ocamlfind ocamlopt -linkpkg \
    -package yojson,lwt,lwt.unix,mysql,unix \
    bin/main.ml -o main
CMD ["./main"]