(* ground-ocaml/bin/main.ml *)
open Yojson.Safe

(* Conexión a MySQL *)
let db_config =
  Mysql.quick_connect ~host:"db" ~user:"root" ~password:"root" ~database:"kepler" ()

(* Insertar mensaje en ground_historial *)
let insert_message ~mensaje_id ~resumen =
  let query = Printf.sprintf
      "INSERT INTO ground_historial (mensaje_id, resumen_consolidado) VALUES (%d, '%s')"
      mensaje_id resumen
  in
  ignore (Mysql.exec db_config query);
  Printf.printf "Mensaje %d insertado en MySQL.\n%!" mensaje_id

(* Simula recibir mensaje JSON de ATLAS *)
let receive_from_atlas () =
  let json_msg = `Assoc [
      ("mensaje_id", `Int 1);
      ("resumen", `String "Reporte de Voyager IX recibido y procesado correctamente")
    ]
  in
  let mensaje_id = json_msg |> Util.member "mensaje_id" |> Util.to_int in
  let resumen    = json_msg |> Util.member "resumen"     |> Util.to_string in
  insert_message ~mensaje_id ~resumen

(* Consulta desde Ground *)
let query_ground () =
  let result = Mysql.exec db_config "SELECT * FROM ground_historial;" in
  Printf.printf "\n=== Datos en ground_historial ===\n";
  (match Mysql.fetch result with
   | None -> Printf.printf "(sin datos)\n"
   | Some _ ->
     let rec loop () =
       match Mysql.fetch result with
       | None -> ()
       | Some row ->
         Array.iter (fun col ->
           Printf.printf "%s\t" (match col with Some s -> s | None -> "NULL")
         ) row;
         Printf.printf "\n";
         loop ()
     in loop ());
  Printf.printf "===============================\n%!"

(* Loop principal *)
let rec loop () =
  receive_from_atlas ();
  query_ground ();
  Unix.sleep 5;
  loop ()

let () =
  Printf.printf "Nodo GROUND iniciado...\n%!";
  loop ()