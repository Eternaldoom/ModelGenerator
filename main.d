/+
Author: Eternaldoom. This program is distributed under the MIT License. Do whatever you want with it.
You don't need to give me credit if you use it to generate models. However, I'd love to try out your mods!
+/

module main;

import std.stdio;
import core.stdc.stdlib;
import std.string;
import std.file;

string cyanFormat = "\033[1;36m";
string resetFormat = "\033[0m";

int main(){
	auto repeated = false;
	char[] directory;
	char[] modid;
	writeln(cyanFormat ~ "Welcome to Eternaldoom's Minecraft model generator version 1.0!\nPlease enter an output directory to get started:" ~ resetFormat);
	write("\033[1;36m>\033[0m");
	readln(directory);
	directory = cast(char[])removechars(directory, "\n");
	if(!directory.startsWith("/"))directory = getcwd ~ "/" ~ directory;
	if(!exists(directory))mkdir(directory);
	if(!exists(directory ~ "/blockstates"))mkdir(directory ~ "/blockstates");
	if(!exists(directory ~ "/models"))mkdir(directory ~ "/models");
	if(!exists(directory ~ "/models/item"))mkdir(directory ~ "/models/item");
	if(!exists(directory ~ "/models/block"))mkdir(directory ~ "/models/block");

	writeln(cyanFormat ~ "Ok, now enter a mod ID. If you are making a resource pack, this should be \"minecraft\"." ~ resetFormat);
	write("\033[1;36m>\033[0m");
	readln(modid);
	modid = cast(char[])removechars(modid, "\n");

	while(true){
		char[] type;
		if(!repeated) writeln(cyanFormat ~ "Now enter \"item\" if you want an item model, \"block\" if you want a block model, or \"tool\" if you want to make a tool model:" ~ resetFormat);
		else writeln(cyanFormat ~ "Enter \"item\", \"block\", or \"tool\" again to make another model or \"quit\" to quit." ~ resetFormat);
		write("\033[1;36m>\033[0m");
		readln(type);
		type = cast(char[])removechars(type, "\n");
		switch(cast(string)type){
			case "quit": 
				return 0;
			case "item":
				generateItem(directory, modid);
				repeated = true;
				break;
			case "tool":
				generateTool(directory, modid);
				repeated = true;
				break;
			case "block":
				generateBlock(directory, modid);
				repeated = true;
				break;
			default: writeln(type);break;
		}
	}
		return 0;
}

void generateItem(char[] directory, char[] modid){
	char[] itemName;
	writeln(cyanFormat ~ "Enter a name for the item. This should be its registered name, not its unlocalized name:" ~ resetFormat);
	write("\033[1;36m>\033[0m");
	readln(itemName);
	itemName = cast(char[])removechars(itemName, "\n");
	string fileName = cast(string)directory ~ "/models/item/" ~ cast(string)itemName ~ ".json";
	File* f = new File(fileName, "w");
	f.write("{\n    \"parent\": \"" ~ modid ~ ":builtin/generated\",\n    \"textures\": {\n        \"layer0\": \"" ~ modid ~ ":items/" ~ itemName ~ "\"\n    },\n    \"display\": {\n        \"thirdperson\": {\n            \"rotation\": [ -90, 0, 0 ],\n            \"translation\": [ 0, 1, -3 ],\n            \"scale\": [ 0.55, 0.55, 0.55 ]\n        },\n        \"firstperson\": {\n            \"rotation\": [ 0, -135, 25 ],\n            \"translation\": [ 0, 4, 2 ],\n            \"scale\": [ 1.7, 1.7, 1.7 ]\n        }\n    }\n}");
	writeln(cyanFormat ~ "The item " ~ itemName ~ " was successfully created!" ~ resetFormat);
}

void generateTool(char[] directory, char[] modid){
	char[] itemName;
	writeln(cyanFormat ~ "Enter a name for the tool. This should be its registered name, not its unlocalized name:" ~ resetFormat);
	write("\033[1;36m>\033[0m");
	readln(itemName);
	itemName = cast(char[])removechars(itemName, "\n");
	string fileName = cast(string)directory ~ "/models/item/" ~ cast(string)itemName ~ ".json";
	File* f = new File(fileName, "w");
	f.write("{\n    \"parent\": \"" ~ modid ~ ":builtin/generated\",\n    \"textures\": {\n        \"layer0\": \"" ~ modid ~ ":items/" ~ itemName ~ "\"\n    },\n    \"display\": {\n        \"thirdperson\": {\n            \"rotation\": [ 0, 90, -35 ],\n            \"translation\": [ 0, 1.25, -3.5 ],\n            \"scale\": [ 0.85, 0.85, 0.85 ]\n        },\n        \"firstperson\": {\n            \"rotation\": [ 0, -135, 25 ],\n            \"translation\": [ 0, 4, 2 ],\n            \"scale\": [ 1.7, 1.7, 1.7 ]\n        }\n    }\n}");
	writeln(cyanFormat ~ "The tool " ~ itemName ~ " was successfully created!" ~ resetFormat);
}

void generateBlock(char[] directory, char[] modid){
	char[] blockName;
	writeln(cyanFormat ~ "Enter a name for the block. This should be its registered name, not its unlocalized name:" ~ resetFormat);
	write("\033[1;36m>\033[0m");
	readln(blockName);
	blockName = cast(char[])removechars(blockName, "\n");
	string blockModelName = cast(string)directory ~ "/models/block/" ~ cast(string)blockName ~ ".json";
	File* f1 = new File(blockModelName, "w");
	f1.write("{\n    \"parent\": \"block/cube_all\",\n    \"textures\": {\n        \"all\": \"" ~ modid ~ ":blocks/" ~ blockName ~ "\"\n    }\n}");
	f1.close();
	string itemModelName = cast(string)directory ~ "/models/item/" ~ cast(string)blockName ~ ".json";
	File* f2 = new File(itemModelName, "w");
	f2.write("{\n    \"parent\": \"" ~ modid ~ ":block/" ~ blockName ~ "\",\n    \"display\": {\n        \"thirdperson\": {\n            \"rotation\": [ 10, -45, 170 ],\n            \"translation\": [ 0, 1.5, -2.75 ],\n            \"scale\": [ 0.375, 0.375, 0.375 ]\n        }\n    }\n}");
	f2.close();
	string blockStateName = cast(string)directory ~ "/blockstates/" ~ cast(string)blockName ~ ".json";
	File* f3 = new File(blockStateName, "w");
	f3.write("{\n    \"variants\": {\n        \"normal\": { \"model\": \"" ~ modid ~ ":" ~ blockName ~ "\" }\n    }\n}");
	writeln(cyanFormat ~ "The block " ~ blockName ~ " was successfully created, along with an ItemBlock model and a blockstate file." ~ resetFormat);
}