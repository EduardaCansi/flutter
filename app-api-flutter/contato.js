module.exports = (app) => {
   var array = [
      {'_id':'1', 'nome':'Jaqson', 'email':'jaqson@upf.br', 'telefone':'54 65664-0536'},
      {'_id':'2', 'nome':'Fulano', 'email':'fulano@upf.br', 'telefone':'54 87878-0636'}
   ];

   app.get('/contato', (req, res) => {
      res.json(array);
   });

   app.post('/contato', (req, res, next) => {
      if (req.body._id === null){
         req.body._id = (array.length+1).toString();
      }
      array.push(req.body);
      res.json({success: "Incluído"});
   });
 
   app.put('/contato', (req, res) => {
      for (i = 0; i < array.length; i++) {
         if (array[i]._id === req.body._id){
            array[i] = req.body;
            return res.json({success: "Alterado com sucesso."});
         }
      };
      return res.json({aviso: "Nada alterado."});
   });

   app.delete('/contato/:_id', (req, res) => {
      for (i = 0; i < array.length; i++) {
         if (array[i]._id === req.params._id){
            array.splice(i, 1);
            return res.json({success: "Excluído com sucesso."});
         }
      };
      return res.json({aviso: "Nada excluído."});
   }); 

   app.get('/contato/:_id', (req, res) => {
      for (i = 0; i < array.length; i++) {
         if (array[i]._id === req.params._id){
            return res.json(array[i]);
         }
      };
      return res.json({aviso: "Não encontrado."});
   });


 }