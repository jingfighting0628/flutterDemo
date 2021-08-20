import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()

class User{ 
  User(this.name, this.email); 
  String name; String email; //不同的类使⽤不同的mixin即可 
factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
 Map<String, dynamic> toJson() => _$UserToJson(this);
 }
 //json_serializable 第⼀次创建类时，您会看到与下图类似的错误。
 //这些错误是完全正常的，这是因为Model类的⽣成代码还不存在。为了解决这个问题，我们必须运⾏代码⽣成器来为我 们⽣成序列化模板。
 //有两种运⾏代码⽣成器的⽅法
 //⾃动化⽣成模板 上⾯的⽅法有⼀个最⼤的问题就是要为每⼀个json写模板，这是⽐较枯燥的。如果有⼀个⼯具可以直接根据JSON⽂本 ⽣成模板，那我们就能彻底解放双⼿了。
 //笔者⾃⼰⽤dart实现了⼀个脚本，它可以⾃动⽣成模板，并直接将JSON转为 Model类，下⾯我们看看怎么做：