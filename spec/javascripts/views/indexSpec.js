describe("Teste do script de load da pagina de healthcheck", function(){

  it("deve retornar true para a mudança de status", function(){
    var retorno = changeStatus("a", "b");
    expect(retorno).toEqual(true);
  });

  it("deve retornar false para a não mudança de status", function(){
    var retorno = changeStatus("a", "a");
    expect(retorno).toEqual(false);
  });
  
  it("Deve montar corretamente o html", function(){
    projeto = function(){}
    projeto.name = "teste";
    projeto.id ="1";
    var expected_html = '<li id="1" status="200" class="projeto">'
    expected_html +=' <span>teste</span>';
    expected_html +=' <span class="check_sign;al"></span>';
    expected_html +=' <div>';
    expected_html +=' <ul></ul>';
    expected_html +=' </div>';
    expected_html +=' </li>';
    var retorno  = html_monitor_for(projeto);
    expect(retorno).toEqual(expected_html);
  });
});
