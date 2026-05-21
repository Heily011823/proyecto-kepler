FROM ocaml/opam:debian-12-ocaml-5.1
WORKDIR /app

COPY . .

RUN opam install dune yojson lwt --yes
RUN dune build bin/main.exe

CMD ["dune", "exec", "bin/main.exe"]