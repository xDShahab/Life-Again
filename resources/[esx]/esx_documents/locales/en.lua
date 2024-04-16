Locales['en'] = {
    ['document_deleted'] = "Document was deleted.",
    ['document_delete_failed'] = "Document delete failed.",
    ['copy_from_player'] = "You received a form copy from a player.",
    ['from_copied_player'] = "Form copied to player",
    ['could_not_copy_form_player'] = "Could not copy form to player.",
    ['document_options'] = "gozine haye form",
    ['public_documents'] = "form haye omomy",
    ['job_documents'] = "form haye kary",
    ['saved_documents'] = "form haye zakhire shode",
    ['close_bt'] = "bastan",
    ['no_player_found'] = "kasi inja nist",
    ['go_back'] = "bargasht",
    ['view_bt'] = "tamasha kardan",
    ['show_bt'] = "neshan dadan",
    ['give_copy'] = "copy ",
    ['delete_bt'] = "delete",
    ['yes_delete'] = "bale delete shavad",
}

Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "Form Ta,hod",
          headerSubtitle = "Form Ta,hod Shahrvandi.",
          elements = {
		    { label = "Fard Morede Nazar", type = "input", value = "", can_be_emtpy = false },
			{ label = "Onvan Taahod", type = "input", value = "", can_be_emtpy = false },
            { label = "Mavared Ta,hod", type = "textarea", value = "Injaneb Mavarede Zir ra morede Taahode Khod Midanam: 1-", can_be_emtpy = false, can_be_edited = true },
          }
        },
		{
          headerTitle = "Form Ta,hod Shoghli",
          headerSubtitle = "Form Ta,hod Shoghli baraye Estekhdam.",
          elements = {
		    { label = "Organ Morede Nazar", type = "input", value = "", can_be_emtpy = false },
			{ label = "Reis Organ", type = "input", value = "", can_be_emtpy = false },
            { label = "Mavared Ta,hod", type = "textarea", value = "Injaneb Tamame Ghavanin in organ ra khandeh va be an kamelan amal khaham kard. Dar gheire in Sorat Masoliate kar haye khod ra mipaziram.", can_be_emtpy = false, can_be_edited = false },
          }
        },
        {
          headerTitle = "Shahadet Nameh, ",
          headerSubtitle = "Shahdat Nameh Rasmi.",
          elements = {
            { label = "Tarikhe Voghoo Etefagh", type = "input", value = "", can_be_emtpy = false },
			{ label = "Mahale Voghoo Etefagh", type = "input", value = "", can_be_emtpy = false },
            { label = "Matne Shahadat", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "Gholname Enteghal Malekiat Khodro",
          headerSubtitle = "Enteghal Malekiat Khodro be Shahrvandi digar az Soye Foroshande.",
          elements = {
            { label = "Name Kharidar", type = "input", value = "", can_be_emtpy = false },
            { label = "Shomare Pelak", type = "input", value = "", can_be_emtpy = false },
			{ label = "Type Mashin", type = "input", value = "", can_be_emtpy = false },
            { label = "Gheymat Tavafoghi", type = "input", value = "", can_be_empty = false },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "Bayanie daryaft gharz",
          headerSubtitle = "Bayanie Rasmi, Baraye Daryaft gharz az Sayerin.",
          elements = {
            { label = "Name Pardakht Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Elate Gharz Gereftan", type = "input", value = "", can_be_emtpy = true },
            { label = "Mablagh", type = "input", value = "", can_be_empty = false },
            { label = "Tarikh Nahaei Pardakht", type = "input", value = "", can_be_empty = true },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "Bayanie Daryaft Bedehi",
          headerSubtitle = "Ta,ahod be Pardakht Shodan Bedehi.",
          elements = {
            { label = "Name Bedehkar", type = "input", value = "", can_be_emtpy = false },
            { label = "Mablagh", type = "input", value = "", can_be_empty = false },
            { label = "Etela,at Digar", type = "textarea", value = "Man Taeid mikonam ke shakhs mored nazar bedehi khod ra pardakht karde ast", can_be_emtpy = false, can_be_edited = true },
          } 
        },
		{
          headerTitle = "Esteshhad Name",
          headerSubtitle = "Form Govahi Mavarede Moshahede Shode",
          elements = {
            { label = "Mahale Vaghe e", type = "input", value = "", can_be_emtpy = false },
            { label = "Roz Vaghe e", type = "input", value = "", can_be_emtpy = false },
            { label = "Zaman Vaghe e", type = "input", value = "", can_be_empty = false },
			{ label = "Secret?", type = "input", value = "", can_be_empty = false },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = false},
          } 
        },
		{
          headerTitle = "Shekayat Name",
          headerSubtitle = "Form Shekayat Name az Sayere Shahrvandan",
          elements = {
            { label = "Mahale Voghoo", type = "input", value = "", can_be_emtpy = false },
            { label = "Zaman Voghoo", type = "input", value = "", can_be_emtpy = false },
            { label = "Afrade morede Shekayat", type = "input", value = "", can_be_empty = false },
			{ label = "Shahedan", type = "input", value = "", can_be_empty = true },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = false},
          } 
        },
		{
          headerTitle = "Eteraf Name",
          headerSubtitle = "Form Tozih Mavarede Eteraf Shode",
          elements = {
			{ label = "Mozoe Eteraf", type = "input", value = "", can_be_emtpy = false },
            { label = "Mahale Voghoo", type = "input", value = "", can_be_emtpy = false },
            { label = "Roz Vogho", type = "input", value = "", can_be_emtpy = false },
            { label = "Zaman Voghoo", type = "input", value = "", can_be_empty = false },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = false},
          } 
        },
		{
          headerTitle = "Vekalat Name",
          headerSubtitle = "Form Dadane Vekalat Baraye Anjam Kar Moshakhas Shode",
          elements = {
            { label = "Esme Vakil", type = "input", value = "", can_be_emtpy = false },
            { label = "Morede Vekalat", type = "input", value = "", can_be_emtpy = false },
            { label = "Zaman Etebar", type = "input", value = "", can_be_empty = false },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = false},
          } 
        },
		{
          headerTitle = "Resid",
          headerSubtitle = "Resid Parkhat Mabghlagh Moshakhas Shode",
          elements = {
            { label = "Fard Pardakht Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Mablaghe Daryafti", type = "input", value = "", can_be_emtpy = false },
            { label = "Elate Pardakht", type = "input", value = "", can_be_empty = false },
            { label = "Etela,at Digar", type = "textarea", value = "", can_be_emtpy = true},
          } 
        },
		{
          headerTitle = "Sabeghe Kar",
          headerSubtitle = "Govahi Sabeghe Kari az Shoghle Sabegh",
          elements = {
            { label = "Name karmand", type = "input", value = "", can_be_emtpy = false },
            { label = "Akharin Rotbe Shoghli", type = "input", value = "", can_be_emtpy = false },
            { label = "Modat Zaman Khedmat", type = "input", value = "", can_be_empty = false },
			{ label = "Mizan Rezayat", type = "input", value = "", can_be_empty = true },
            { label = "Etela,at Digar", type = "textarea", value = "Bedin vasile man Rezayate khord ra az Karmand Morede Nazar Elam Mikonam.", can_be_emtpy = false, can_be_edited = true},
          } 
        }
	  },
      ["police"] = {
        {
          headerTitle = "Mojavez Hamle Teaser",
          headerSubtitle = "Mojavez Ekhtesasi Teaser Baraye Mashaghele Dolati.",
          elements = {
            { label = "Name Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghl Fard", type = "input", value = "", can_be_emtpy = false },
            { label = "Etela,at Digar", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Mojavez Hamle Teaser ra darad.", can_be_emtpy = false, can_be_edited = true },
          } 
        },
		{
          headerTitle = "Estelaam Nameh Adame Soe Pishine",
          headerSubtitle = "Soe Pishineye Sade Elzaman Tavasote Officer 2 va Balatar",
          elements = {
            { label = "Name Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghl Fard", type = "input", value = "", can_be_emtpy = false },
			{ label = "Organ Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Etela,at Digar", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Soe Pishine nadarad.", can_be_emtpy = false, can_be_edited = true },
          } 
        },
		{
          headerTitle = "Adame Vojode Bedehi",
          headerSubtitle = "Govahie Adam Vojod hargone Bedehi va ya Jarimeh.",
          elements = {
            { label = "Name Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghl Fard", type = "input", value = "", can_be_emtpy = true },
			{ label = "Organ Darkhast Konande", type = "input", value = "", can_be_emtpy = true },
			{ label = "Moddat Etebar", type = "input", value = "1 Roz", can_be_emtpy = false, can_be_edited = false },
            { label = "Etela,at Digar", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Hichgone Bedehi va ya Jarime nadarad.", can_be_emtpy = false, can_be_edited = true },
          } 
        },
		{
          headerTitle = "Taeidie Govahiname",
          headerSubtitle = "Govahie Taeid Motabar bodan Govahiname",
          elements = {
            { label = "Name Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghl Feeli", type = "input", value = "", can_be_emtpy = true },
			{ label = "Organ Darkhast Konande", type = "input", value = "", can_be_emtpy = true },
			{ label = "Noe Govahiname", type = "input", value = "", can_be_emtpy = false },
            { label = "Etela,at Digar", type = "textarea", value = "Bedin Vasile, Injaneb Mavared va Noe Govahiname Zekr shode ra Taeid Mikonam", can_be_emtpy = false, can_be_edited = true },
          } 
        },
        {
          headerTitle = "Mojavaz Vorod",
          headerSubtitle = "Mojaveze Vorod Khabarnegar be Zendan",
          elements = {
            { label = "Name Khabarnegar", type = "input", value = "", can_be_emtpy = false },
            { label = "Elate Vorod", type = "input", value = "", can_be_emtpy = false },
            { label = "tedade Khabarnegaran", type = "input", value = "", can_be_empty = false },
            { label = "Matne Este,lam", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde, Baraye Mavarede Bala Mojaveze Vorod Be Zendan ra Darad", can_be_emtpy = false, can_be_edited = true },
          }         }
       },
       ["ambulance"] = {
        {
          headerTitle = "Govahie Salamate Ravani",
          headerSubtitle = "Report Pezeshki baraye Salamate Asab va Ravani.",
          elements = {
            { label = "Name Moraje e Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Sazman Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghle Feli", type = "input", value = "", can_be_empty = false },
            { label = "Yaddasht Pezeshki", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Hichgoone moshkel Ravani nadarad.", can_be_emtpy = false, can_be_edited = true },
          }
        },
        {
          headerTitle = "Govahie Salamate Jesmi",
          headerSubtitle = "Report Pezeshki baraye Salamate Fiziki.",
          elements = {
            { label = "Name Moraje e Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Sazman Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghle Feli", type = "input", value = "", can_be_empty = false },
            { label = "Yaddasht Pezeshki", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Hichgoone moshkel Jesmi nadarad.", can_be_emtpy = false, can_be_edited = true },
          }
        },
        {
          headerTitle = "Govahie Salamate Binaei",
          headerSubtitle = "Report Pezeshki baraye Salamate Binaei.",
          elements = {
            { label = "Name Moraje e Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Sazman Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Shoghle Feli", type = "input", value = "", can_be_empty = false },
            { label = "Yaddasht Pezeshki", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Hichgoone moshkel Binaei nadarad.", can_be_emtpy = false , can_be_edited = true},
          }
        },
        {
          headerTitle = "Mojavez Masraf Marijuana",
          headerSubtitle = "Nameh Rasmi Masraf Shakhsi Marijuana.",
          elements = {
            { label = "Name Moraje e Konande", type = "input", value = "", can_be_emtpy = false },          
            { label = "Elate Masraf", type = "input", value = "", can_be_empty = false },
			{ label = "Moddat Etebar Be Roz", type = "input", value = "", can_be_empty = false },
            { label = "Yaddasht Pezeshki", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke namborde mitavanad, 4 Roll Marijuana baraye masraf shakhsi haml konad.", can_be_emtpy = false, can_be_edited = false },
          }         }
       },
        ["fbi"] = {
        {
          headerTitle = "Govahi Adame Soe Pishine",
          headerSubtitle = "Estelaam Nameh Kamel Adame Soe Pishine.",
          elements = {
            { label = "Name Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Organ Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Modat Etebar", type = "input", value = "1 Roz", can_be_empty = false, can_be_edited = false },
            { label = "Etelaat Digar", type = "textarea", value = "Bedin Vasile, Injaneb Taeid Mikonam ke Namborde Hichgone Soe Pishinei nadarad.", can_be_emtpy = false, can_be_edited = true },
          } 
        },
		 {
          headerTitle = "Mamor Makhfi",
          headerSubtitle = "Govahi Sader Shode tavasote FBI baraye Mamoriat haye Secret.",
          elements = {
            { label = "Name Fard", type = "input", value = "", can_be_emtpy = false },
            { label = "Moddat Mamoriat", type = "input", value = "", can_be_emtpy = false },
            { label = "Noe Mamoriat", type = "input", value = "", can_be_empty = false },
            { label = "Sayere Etelaat", type = "textarea", value = "", can_be_emtpy = false},
          }         }
       },
	    ["journaliste"] = {
        {
          headerTitle = "Mojaveze Khabarnegari",
          headerSubtitle = "Mojaveze Khabarnegari az Sahneye khas va ya Zendan.",
          elements = {
            { label = "Name Khabarnegar", type = "input", value = "", can_be_emtpy = false },
            { label = "Makan Morede Nazar", type = "input", value = "", can_be_emtpy = false },
            { label = "Tedade Kolie Khabarnegar", type = "input", value = "", can_be_empty = false },
			{ label = "Modat Etebar", type = "input", value = "", can_be_empty = false },
            { label = "Etelaate Digar", type = "textarea", value = "", can_be_emtpy = true },
          }         }
       },
	    ["mechanic"] = {
        {
          headerTitle = "Moayene Fani",
          headerSubtitle = "Form Taeid Moayene Fani tavasote Mechanici.",
          elements = {
            { label = "Name Sahebe Mashin", type = "input", value = "", can_be_emtpy = false },
            { label = "Shomare Pelak", type = "input", value = "", can_be_emtpy = false },
			{ label = "Esm Mashin", type = "input", value = "", can_be_emtpy = false },
            { label = "Armor Mashin", type = "input", value = "", can_be_empty = false },
            { label = "Etelaat Digar", type = "textarea", value = "Name Mechanic e Mobtadi= ", can_be_emtpy = true , can_be_edited = true },
          } 
        },
		{
          headerTitle = "Mojaveze Off Road",
          headerSubtitle = "Form Taeid Sharayete Offroad tavasote Mechanici.",
          elements = {
            { label = "Name Sahebe Mashin", type = "input", value = "", can_be_emtpy = false },
            { label = "Shomare Pelak", type = "input", value = "", can_be_emtpy = false },
			{ label = "Esm Mashin", type = "input", value = "", can_be_emtpy = false },
            { label = "Tyre Mashin", type = "input", value = "Offroad", can_be_empty = false },
            { label = "Etelaat Digar", type = "textarea", value = "Bedin Vasile Mashine Morede Nazar Haghe Offroad ra Darad", can_be_emtpy = true, can_be_edited = true },
          }         }
       },
	    ["taxi"] = {
        {
          headerTitle = "Ranande Shakhsi",
          headerSubtitle = "Govahie Ekhtesas dadane Ranande Shakhsi.",
          elements = {
            { label = "Name Darkhast Konande", type = "input", value = "", can_be_emtpy = false },
            { label = "Name Ranande", type = "input", value = "", can_be_emtpy = false },
            { label = "Modat Service", type = "input", value = "", can_be_empty = false },
			{ label = "Mablagh Pardakht Shode", type = "input", value = "", can_be_empty = false },
            { label = "Sayere Etelaat", type = "textarea", value = "", can_be_emtpy = true },
          } 
        },

      ["justice"] = {
        {
          headerTitle = "Hokm Ghazi",
          headerSubtitle = "Hokme Ghazi baraye Jorm Moshakhas Shode.",
          elements = {
            { label = "Name Motaham", type = "input", value = "", can_be_emtpy = false },
            { label = "Jorm", type = "input", value = "", can_be_emtpy = false },
            { label = "Modat Zaman Zendan", type = "input", value = "", can_be_empty = false },
			{ label = "Name Vakil", type = "input", value = "", can_be_empty = false },
            { label = "Etelaat Digar", type = "textarea", value = "", can_be_emtpy = true },
          }  
        }
      }
    }
  }