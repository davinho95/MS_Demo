#region DOC
/*
Marley Spoon Task 7 - Dávid István, 2023-03-15
*/
#endregion DOC
report 85000 "MS Customer Report"
{
    Caption = 'Customer Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Default;

    dataset
    {
        dataitem(Header; Integer)
        {
            MaxIteration = 1;

            column(ReportNameLbl; ReportNameLbl)
            {
            }
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(AppliedFilters; StrSubstNo(FilterLbl, AppliedFiltersLbl, Customer.GetFilters(), CustLedgerEntry.GetFilters()))
            {
            }
            column(TotalLbl; TotalLbl)
            {
            }
            column(AppliedFiltersLbl; AppliedFiltersLbl)
            {
            }
            column(NoLbl; NoLbl)
            {
            }
            column(NameLbl; NameLbl)
            {
            }
            column(AddressLbl; AddressLbl)
            {
            }
            column(Address2Lbl; Address2Lbl)
            {
            }
            column(PostCodeLbl; PostCodeLbl)
            {
            }
            column(CityLbl; CityLbl)
            {
            }
            column(DocumentNoLbl; DocumentNoLbl)
            {
            }
            column(DocumentTypeLbl; DocumentTypeLbl)
            {
            }
            column(EntryNoLbl; EntryNoLbl)
            {
            }
            column(AmountLbl; AmountLbl)
            {
            }
            column(ExternalDocNoLbl; ExternalDocNoLbl)
            {
            }
            column(RemainingAmountLbl; RemainingAmountLbl)
            {
            }
        }
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;

            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(Address_Customer; Address)
            {
            }
            column(Address2_Customer; "Address 2")
            {
            }
            column(PostCode_Customer; "Post Code")
            {
            }
            column(City_Customer; City)
            {
            }
            column(QRCodeMedia; QRCodeMedia.Content)
            {
            }
            dataitem(CustLedgerEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = where(Open = const(true));
                CalcFields = "Remaining Amount", Amount;

                column(DocumentNo_CustLedgerEntry; "Document No.")
                {
                }
                column(DocumentType_CustLedgerEntry; "Document Type")
                {
                }
                column(EntryNo_CustLedgerEntry; "Entry No.")
                {
                }
                column(Amount_CustLedgerEntry; Amount)
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "External Document No.")
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Remaining Amount")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CreateQRCode();
                QRCodeMedia.CalcFields(Content);
            end;
        }
    }

    rendering
    {
        layout(Default)
        {
            Type = RDLC;
            LayoutFile = 'src\Features\Customer\Reports\RDLC\CustomerReport.rdlc';
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        QRCodeMedia: Record "Tenant Media" temporary;
        ReportNameLbl: Label 'Customer Report';
        AppliedFiltersLbl: Label 'Applied Filters';
        TotalLbl: Label 'Total';
        NoLbl: Label 'No';
        NameLbl: Label 'Name';
        AddressLbl: Label 'Address';
        Address2Lbl: Label 'Address 2';
        PostCodeLbl: Label 'Post Code';
        CityLbl: Label 'City';
        DocumentNoLbl: Label 'Document No.';
        DocumentTypeLbl: Label 'Document Type';
        EntryNoLbl: Label 'Entry No.';
        AmountLbl: Label 'Amount';
        ExternalDocNoLbl: Label 'External Document No.';
        RemainingAmountLbl: Label 'Remaining Amount';
        FilterLbl: Label '%1: %2 %3', Locked = true;

    local procedure CreateQRCode()
    var
        QRCodeHelper: Codeunit "Swiss QR Code Helper";
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        Source: Text;
        QRCodeLbl: Label '%1#%2', Locked = true;
    begin
        QRCodeMedia.DeleteAll();

        Source := StrSubstNo(QRCodeLbl, Customer."No.", Customer.Name);
        QRCodeHelper.GenerateQRCodeImage(Source, TempBlob);
        InStream := TempBlob.CreateInStream();
        QRCodeMedia.Init();
        QRCodeMedia.Content.CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
        QRCodeMedia.Insert();
    end;

}
