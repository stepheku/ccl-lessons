/*starting query*/
select pt = pt.name_full_formatted
    , anesth = per.name_full_formatted
    , sc.sched_start_dt_tm
from surgical_case sc
    , prsnl per
    , person pt
plan sc where sc.sched_start_dt_tm > cnvtdatetime(curdate-90, 0)
join per where per.person_id = sc.anesth_prsnl_id
join pt where pt.person_id = sc.person_id
with format(date, "mm/dd/yyyy hh:mm:ss"), uar_code(d, 1)

/*final query*/
select pt = pt.name_full_formatted
    , anesth = per.name_full_formatted
    , facility = uar_get_code_display(e.loc_facility_cd)
    , sc.sched_start_dt_tm
    , sa_medication_prsnl = per2.name_full_formatted
    ; Aliasing a column
    ; The column I want is per2.name_full_formatted, but rename the column
    ; in the query to "sa_medication_prsnl"
    , smai.admin_start_dt_tm
    , mi.value
    , smai.admin_dosage
    , sma.dosage_unit_cd
    , smai.admin_amount
    , sma.amount_unit_cd
from surgical_case sc
    ; alias a table
    , prsnl per
    , prsnl per2
    , person pt
    , encounter e
    , sa_anesthesia_record rec
    , sa_medication sm
    , sa_ref_medication sr
    , med_identifier mi
    , sa_medication_admin sma
    , sa_med_admin_item smai
plan sc where sc.sched_start_dt_tm > cnvtdatetime(curdate, 0)
join per where per.person_id = sc.anesth_prsnl_id
join pt where pt.person_id = sc.person_id   
join e where e.encntr_id = sc.encntr_id
join rec where rec.surgical_case_id = sc.surg_case_id
join sm where sm.sa_anesthesia_record_id = rec.sa_anesthesia_record_id
join per2 where per2.person_id = sm.prsnl_id
join sr where sr.sa_ref_medication_id = sm.sa_ref_medication_id
join mi where mi.item_id = sr.item_id
    and mi.primary_ind = 1
    and mi.med_product_id = 0
    and mi.med_identifier_type_cd = value(uar_get_code_by("MEANING", 11000, "DESC"))
join sma where sma.sa_medication_id = sm.sa_medication_id
    and sma.active_ind = 1
join smai where smai.sa_medication_admin_id = sma.sa_medication_admin_id
with format(date, "mm/dd/yyyy hh:mm:ss"), uar_code(d, 1)
