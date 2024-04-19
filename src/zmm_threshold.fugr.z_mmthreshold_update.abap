FUNCTION z_mmthreshold_update.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ZMMT_THRESH_REP) TYPE  ZTTY_ZMMT_THRESH_REP
*"     VALUE(I_WORKITEM) TYPE  SWR_STRUCT-WORKITEMID OPTIONAL
*"----------------------------------------------------------------------

  DATA: ls_zmmt_rep   TYPE zstr_zmmt_thresh_rep,
        ls_update     TYPE zmmt_thresh_rep,
        lt_update     TYPE STANDARD TABLE OF zmmt_thresh_rep.

  LOOP AT i_zmmt_thresh_rep INTO ls_zmmt_rep.
    CLEAR ls_update.
    MOVE-CORRESPONDING ls_zmmt_rep TO ls_update.
    ls_update-apr_confirm = 'X'.
    ls_update-confrim_date = sy-datlo.
    ls_update-confrim_time = sy-uzeit.
    ls_update-ernam = sy-uname.
    APPEND ls_update TO lt_update.
  ENDLOOP.

  LOOP AT lt_update INTO ls_update.
    MODIFY zmmt_thresh_rep FROM ls_update.
  ENDLOOP.

  IF i_workitem IS NOT INITIAL.
    CALL FUNCTION 'SAP_WAPI_WORKITEM_COMPLETE'
      EXPORTING
        workitem_id               = i_workitem
        actual_agent              = sy-uname
        language                  = sy-langu
        do_commit                 = 'X'
        do_callback_in_background = 'X'.
  ENDIF.
ENDFUNCTION.
