describe("Teste do script de load da pagina de healthcheck", function(){

  xit("deve retornar true para a mudança de status", function(){
    var retorno = changeStatus("a", "b");
    expect(retorno).toEqual(true);
  });

  xit("deve retornar false para a não mudança de status", function(){
    var retorno = changeStatus("a", "a");
    expect(retorno).toEqual(false);
  });

});
