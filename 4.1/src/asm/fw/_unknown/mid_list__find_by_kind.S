/* mid_list__find_by_kind @ 0x8ca1f8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__get_status_hal, l2_mgr__pcp_stop, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, l2mgr__disconnect_done, mid_list__remove_entry, scan_mngr__dband_beacon_ind
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.mid_list__find_by_kind,"ax",@progbits
	.global mid_list__find_by_kind
mid_list__find_by_kind:
	.global L_8ca1f8
L_8ca1f8:
	push_s blink
L_8ca1fa:
	bl L_8c02c4
L_8ca1fe:
	sub_s sp,sp,0x4
L_8ca200:
	mov_s r13,r1
L_8ca202:
	mov_s r14,sp
L_8ca204:
	add r1,r0,0x18
L_8ca208:
	bl.d L_8e1138
L_8ca20c:
	mov_s r0,r14
L_8ca20e:
	b_s L_8ca246
	.global L_8ca210
L_8ca210:
	bl.d L_8db188
L_8ca214:
	mov_s r0,r14
L_8ca216:
	breq_s r13,0,L_8ca234
L_8ca218:
	breq r13,0x1,L_8ca23e
L_8ca21c:
	brne r13,0x2,L_8ca230
L_8ca220:
	add3 r2,r0,0x16
L_8ca224:
	ld_s r1,[r2,0x30]
L_8ca226:
	brne_s r1,0,L_8ca250
L_8ca228:
	ldb_s r1,[r2]
L_8ca22a:
	brne r1,0x2,L_8ca246
L_8ca22e:
	b_s L_8ca250
	.global L_8ca230
L_8ca230:
	mov_s r0,0x0
L_8ca232:
	b_s L_8ca250
	.global L_8ca234
L_8ca234:
	ldb r1,[r0, 0xb0]
L_8ca238:
	brne r1,0x1,L_8ca246
L_8ca23c:
	b_s L_8ca250
	.global L_8ca23e
L_8ca23e:
	ldb r1,[r0, 0xb0]
L_8ca242:
	breq r1,0x2,L_8ca250
	.global L_8ca246
L_8ca246:
	bl.d L_8cb674
L_8ca24a:
	mov_s r0,r14
L_8ca24c:
	brne_s r0,0,L_8ca210
L_8ca24e:
	b_s L_8ca230
	.global L_8ca250
L_8ca250:
	b.d L_8c0334
L_8ca254:
	add_s sp,sp,0x4
L_8ca256:
	nop_s
