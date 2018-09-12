/*Checking the order catalog*/
select *
from order_catalog_synonym ocs
where ocs.mnemonic_key_cap like '*IV*TEAM*CONSULT*'
with maxrec = 100, uar_code(d)

/*Final query*/
select e.loc_nurse_unit_cd
    , count(o.order_id)
from orders o
    , encounter e
plan o where o.orig_order_dt_tm > cnvtdatetime(curdate-2, 0)
    and o.product_id = 0
    and o.order_status_cd != value(uar_get_code_by("MEANING", 6004, "DELETED"))
    and o.activity_type_cd = value(uar_get_code_by("DISPLAY_KEY", 106, "IVTEAMCONSULTS"))
    and o.synonym_id = 198327097
join e where e.encntr_id = o.encntr_id
    and e.active_ind = 1
    and e.end_effective_dt_tm > sysdate
group by e.loc_nurse_unit_cd
with maxrec = 100, uar_code(d), format(date, "mm/dd/yyyy hh:mm:ss")
