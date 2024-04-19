FUNCTION z_mmthreshold_read.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_AEDAT) TYPE  AEDAT
*"     REFERENCE(I_USNAME) TYPE  XUBNAME
*"  EXPORTING
*"     REFERENCE(E_ZMMT_THRESH_DATA) TYPE  ZTTY_ZMMT_THRESH_REP
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  DATA: lt_zmmt_thresh_rep  TYPE STANDARD TABLE OF zmmt_thresh_rep,
        ls_zmmt             TYPE zstr_zmmt_thresh_rep.

  FIELD-SYMBOLS: <fs_zmmt>  TYPE zmmt_thresh_rep.


  SELECT *
    FROM zmmt_thresh_rep
    INTO TABLE lt_zmmt_thresh_rep
    WHERE aedat <= i_aedat
      AND doa_approver = i_usname
      AND apr_confirm NE 'X'.

  IF sy-subrc <> 0.
    RAISE no_data.
  ENDIF.

  LOOP AT lt_zmmt_thresh_rep ASSIGNING <fs_zmmt>.
    ls_zmmt-aedat = <fs_zmmt>-aedat.
    ls_zmmt-ebeln = <fs_zmmt>-ebeln.
    ls_zmmt-shopng_crt_no = <fs_zmmt>-shopng_crt_no.
    ls_zmmt-shopng_decrip = <fs_zmmt>-shopng_decrip.
    ls_zmmt-netpr = <fs_zmmt>-netpr.
    ls_zmmt-net_price = <fs_zmmt>-net_price.
    ls_zmmt-afnam = <fs_zmmt>-afnam.
    ls_zmmt-ekgrp = <fs_zmmt>-ekgrp.
    ls_zmmt-doa_approver = <fs_zmmt>-doa_approver.
    ls_zmmt-apr_confirm = <fs_zmmt>-apr_confirm.
    ls_zmmt-confrim_date = <fs_zmmt>-confrim_date.
    ls_zmmt-confrim_time = <fs_zmmt>-confrim_time.
    ls_zmmt-ernam = <fs_zmmt>-ernam.
    ls_zmmt-comments = <fs_zmmt>-comments.
    APPEND ls_zmmt TO e_zmmt_thresh_data.
    CLEAR <fs_zmmt>.
  ENDLOOP.
ENDFUNCTION.
