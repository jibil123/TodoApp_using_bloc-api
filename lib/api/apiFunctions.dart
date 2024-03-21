import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

submitData(String title, String description) async {
  final body = {"title": title, "description": description};
  const url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  try {
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
        if(response.statusCode==201){
          print('success');
          return 'success';
        }
  } catch (e) {
    throw Exception(e);
  }
} 

 Future<List<dynamic>>fetchdata()async{
  try{
    const url= 'https://api.nstack.in/v1/todos?page=1&limit=10';
  final uri=Uri.parse(url);
  final response=await http.get(uri);
  if(response.statusCode==200){
    final result=jsonDecode(response.body);
    return result['items'];
  }
  return [];
  }catch(e){
    throw Exception(e.toString());
  }
}

  Future<http.Response> deletebyid(String id) async {
    try {
      final url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);

      final response = await http.delete(uri);
      return response;
    } catch (e) {
      return http.Response('error deleting data:$e', 500);
    }
  }

  deletedata(String id) async {
    try {
      final response = await deletebyid(id);
      if (response.statusCode == 200) {
        return "success";
      }
    } catch (e) {
      return "failure";
    }
  }

    updatedata(String id, String title, String description) async {
    try {
      final body = dataProviderEditData(title, description);
      final url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);
      
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      
      if (response.statusCode == 200) {
       
        return "success";
      } else {
      
      }
    } catch (e) {
      
      return "failure";
    }
  }
 Map<String, String> dataProviderEditData(String title, String description) {
    final body = {"title": title, "description": description};
    return body;
  }
