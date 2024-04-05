page 50110 Home
{
    PageType = Card;

    actions
    {
        area(Navigation)
        {
            action("Items List")
            {
                ApplicationArea = All;
                RunObject = page "Items List";
            } 
            action("TMA Request List")
            {
                ApplicationArea = All;
                RunObject = page "TMA Request List";
            }
        }
    }
}

table 50100 "Item directory"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }

        field(2; "Item Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Techno", "Home", "Clothes";
        }

        field(3; "Unit of measurement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Quantity", "Meter", "Kilogram";
        }

        field(4; "Quantity"; Decimal)
        {
            MinValue = 0;
            NotBlank = true;
        }

        field(5; "Price without VAT (UAH)"; Decimal)
        {
            MinValue = 0;
            NotBlank = true;
        }

        field(6; Status; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }

        field(7; "Storage location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Contact person"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(9; Photo; Media)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Item ID")
        {
            Clustered = true;
        }
    }
}

page 50101 "Items Card"
{
    PageType = Card;
    UsageCategory = Tasks;
    SourceTable = "Item directory";

    layout
    {
        area(content)
        {
            group(Item)
            {
                field("Item ID"; Rec."Item ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Item Group"; Rec."Item Group")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field("Unit of measurement"; Rec."Unit of measurement")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field("Price without VAT (UAH)"; Rec."Price without VAT (UAH)")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field("Storage location"; Rec."Storage location")
                {
                    ApplicationArea = All;
                }

                field("Contact person"; Rec."Contact person")
                {
                    ApplicationArea = All;
                }

                field(Photo; Rec.Photo)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
                var
                begin
                    Rec.TestField(Status);
                    Rec.TestField(Quantity);
                end;
}

page 50102 "Items List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Item directory";
    CardPageId = "Items Card";

    layout
    {
        area(content)
        {
            repeater(Items)
            {
                field("Item ID"; Rec."Item ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Item Group"; Rec."Item Group")
                {
                    ApplicationArea = All;
                }

                field("Unit of measurement"; Rec."Unit of measurement")
                {
                    ApplicationArea = All;
                }

                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                }

                field("Price without VAT (UAH)"; Rec."Price without VAT (UAH)")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Storage location"; Rec."Storage location")
                {
                    ApplicationArea = All;
                }

                field("Contact person"; Rec."Contact person")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
table 50103 "TMA Requests"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }

        field(2; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }

        field(3; "Item ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item directory";
            NotBlank = true;
        }

        field(4; "Unit of Measurement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Quantity", "Meter", "Kilogram";
            Editable = false;
        }

        field(5; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }

        field(6; "Price without VAT (UAH)"; Decimal)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            Editable = false;
        }
        field(7; "Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "New", "Approved", "Rejected";
        }

        field(9; "Request Row ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Request ID")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
            var
                ItemRec: Record "Item directory";
            begin
                if "Item ID" <> 0 then
                begin
                    if ItemRec.Get("Item ID") then
                    begin
                        "Price without VAT (UAH)" := Quantity * ItemRec."Price without VAT (UAH)";
                        "Unit of Measurement" := ItemRec."Unit of measurement";
                    end;
                end;
            end;
}

page 50104 "TMA Request Card"
{
    PageType = Card;
    UsageCategory = Tasks;
    SourceTable = "TMA Requests";

    layout
    {
        area(content)
        {
            group("Request Details")
            {
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    NotBlank = true; 
                }

                field("Item ID"; Rec."Item ID")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field("Unit of Measurement"; Rec."Unit of Measurement")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    Editable = false;
                }

                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field("Price without VAT (UAH)"; Rec."Price without VAT (UAH)")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    Editable = false;
                }

                field("Comment"; Rec.Comment)
                {
                    ApplicationArea = All;
                }

                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Request Row ID"; Rec."Request Row ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Accept")
                {
                    ApplicationArea = All;
                    Caption = 'Accept';
                    Image = Document;
                    trigger OnAction()
                            var
                                ItemRec: Record "Item directory";
                            begin
                                if ItemRec.GET(Rec."Item ID") then
                                begin
                                    if ItemRec."Quantity" >= Rec."Quantity" then
                                    begin
                                        ItemRec."Quantity" := ItemRec."Quantity" - Rec."Quantity";
                                        ItemRec.MODIFY;
                                        Rec.DELETE;
                                        Message('Request accepted and deleted.');
                                    end
                                    else
                                    begin
                                        Error('Insufficient quantity of item in stock.');
                                    end;
                                end
                                else
                                begin
                                    Error('Item not found in the item directory.');
                                end;
                            end;
                }

            action("Decline")
            {
                ApplicationArea = All;
                Caption = 'Decline';
                Image = Document;
                trigger OnAction()
                begin
                    Rec.Delete;
                    Message('Decline');
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
                var
                begin
                    Rec.TestField("Employee Name");
                    Rec.TestField("Item ID");
                    Rec.TestField(Quantity);
                end;
}

page 50105 "TMA Request List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "TMA Requests";
    CardPageId = "TMA Request Card";

    layout
    {
        area(content)
        {
            repeater(Requests)
            {
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }

                field("Item ID"; Rec."Item ID")
                {
                    ApplicationArea = All;
                }

                field("Unit of Measurement"; Rec."Unit of Measurement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                }

                field("Price without VAT (UAH)"; Rec."Price without VAT (UAH)")
                {
                    ApplicationArea = All;
                }

                field("Comment"; Rec."Comment")
                {
                    ApplicationArea = All;
                }

                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}