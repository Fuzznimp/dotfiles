; Storage keywords → orange (#e78a4e)
(lexical_declaration ["const" "let"] @keyword.modifier)
(variable_declaration "var" @keyword.modifier)
"async" @keyword.modifier
"await" @keyword.modifier

; Import / export → purple (#d3869b)
(import_statement "import" @keyword.import)
(import_statement "from" @keyword.import)
(export_statement "export" @keyword.export)
(export_statement "default" @keyword.export)
(export_statement "from" @keyword.import)

; Type keyword → orange (#e78a4e)
(type_alias_declaration "type" @keyword.type)

; Type/class/interface/enum definition names → aqua (#89b482)
(class_declaration name: (type_identifier) @type.class.definition)
(interface_declaration name: (type_identifier) @type.interface)
(type_alias_declaration name: (type_identifier) @type.definition)
(enum_declaration name: (identifier) @type.class.definition)
