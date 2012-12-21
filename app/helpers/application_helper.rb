# -*- coding: utf-8 -*- 
module ApplicationHelper
  def get_frase_chorra
    frases_chorras = ["¡¡ qué marcha me llevas !!", 
                      "Hay que ver, hay que ver", 
                      "Pues se ha quedao buena tarde, si...", 
                      "Pasa y cierra ya, que se escapa el gatete!!",
                      "Por casualidad... ¿no tendreis séis dedos en vuestra mano derecha?",
                      "¿No serás franchute, tu? ¿no? quesquesé quesquesé",
                      "Bueno, te dejo que tengo las lentejas en el fuego!"
                      "Yo hoy ando comsí comsá, regulerer flavour day..."]

    frases_chorras[rand(frases_chorras.length)]
  end

  def get_saludo username
    saludos = ["¡¡ Hombre, #{username} !!", 
              "Callarse, que ya está #{username} aquí!!!", 
              "#{username} is in da house!!", 
              "Muy buenas, #{username}",
              "Leroloerijiiiii #{username}",
              "Ala, ya ha llegao #{username}, ya estamos todos!",
              "Hombre, #{username}, a ti te quería ver yo!",
              "Por fin aparece #{username}, quita el cartel de 'Se Busca' ya",
              "¿#{username} ande te habías metío, chiquillo?"]
    saludos[rand(saludos.length)]

  end


end
