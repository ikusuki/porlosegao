# -*- coding: utf-8 -*- 
module ApplicationHelper
  def get_frase_chorra
    frases_chorras = ["¡¡ qué marcha me llevas !!", 
                      "Hay que ver, hay que ver", 
                      "Pues se ha quedao buena tarde, si...", 
                      "Pasa y cierra ya, que se escapa el gatete!!",
                      "Por casualidad... ¿no tendreis séis dedos en vuestra mano derecha?"]
    frases_chorras[rand(frases_chorras.length)]
  end

  def get_saludo username
    saludos = ["¡¡ Hombre, #{username} !!", 
               "Callarse, que ya está #{username} aquí!!!", 
               "#{username} is in da house!!", 
               "Muy buenas, #{username}",
               "Leroloerijiiiii #{username}"]
    saludos[rand(saludos.length)]

  end


end
