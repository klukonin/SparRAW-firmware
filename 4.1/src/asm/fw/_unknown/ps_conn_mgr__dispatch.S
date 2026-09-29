/* ps_conn_mgr__dispatch @ 0x8dd300, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__set_awake_tsf
 * Зовёт сам: ps_assoc_sm__on_reenter_done, ps_conn_mgr__notify_all, ps_conn_mgr__on_disassoc, ps_conn_mgr__report_psc_transitions, ps_connection_mgr__on_assoc
 */
	.section .text.ps_conn_mgr__dispatch,"ax",@progbits
	.global ps_conn_mgr__dispatch
ps_conn_mgr__dispatch:
	.global L_8dd300
L_8dd300:
	/* brhs r0,0x8,0x008dd32c */
	.byte 0x2d,0x08,0x15,0x02
L_8dd304:
	ldb.x r10,[0x8019fc,r0]
L_8dd30c:
	add r2,pcl,0xa
L_8dd310:
	add1 r2,r2,r10
L_8dd314:
	j_s [r2]
L_8dd316:
	b.d L_8c338c
L_8dd31a:
	extb_s r0,r1
L_8dd31c:
	b.d L_8c79c8
L_8dd320:
	extb_s r0,r1
L_8dd322:
	b.d L_8c3618
L_8dd326:
	mov_s r0,r1
L_8dd328:
	b L_8c4e20
