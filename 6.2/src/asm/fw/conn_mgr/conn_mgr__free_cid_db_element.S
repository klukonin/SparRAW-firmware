/* conn_mgr__free_cid_db_element @ 0x8caf54, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::free_cid_db_element() CID %d::::: 0x%x status %d.
 * Зовут его: conn_mgr__link_down_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3, fw_sysassert_fatal, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__free_cid_db_element
conn_mgr__free_cid_db_element:
	.global L_8caf54
L_8caf54:
	push_s blink
L_8caf56:
	bl.d L_8c01e4
L_8caf5a:
	mov_s r2,r0
L_8caf5c:
	mov_s r1,0x100bcf0
L_8caf62:
	mov_s r13,0x854080
L_8caf68:
	add3_s r13,r13,r0
L_8caf6a:
	ld r4,[r13]
L_8caf6e:
	mov_s r0,0x2b
L_8caf70:
	bl.d L_8dcd00
L_8caf74:
	ld_s r3,[r13,0x4]
L_8caf76:
	ld_s r0,[r13]
L_8caf78:
	mov_s r14,0x8540c0
L_8caf7e:
	breq_s r0,0,L_8caf96
	.global L_8caf80
L_8caf80:
	ld_s r0,[r13,0x4]
L_8caf82:
	breq_s r0,0,L_8cafa4
	.global L_8caf84
L_8caf84:
	mov_s r0,r14
L_8caf86:
	bl.d L_8caed0
L_8caf8a:
	ld_s r1,[r13,0x4]
L_8caf8c:
	mov_s r0,0x0
L_8caf8e:
	st_s r0,[r13,0x4]
L_8caf90:
	b.d L_8c0254
L_8caf94:
	st_s r0,[r13]
	.global L_8caf96
L_8caf96:
	mov_s r0,blink
L_8caf98:
	mov_s r1,0x11cf
L_8caf9e:
	bl L_8c9b28
L_8cafa2:
	b_s L_8caf80
	.global L_8cafa4
L_8cafa4:
	mov_s r0,blink
L_8cafa6:
	mov_s r1,0x11d0
L_8cafac:
	bl L_8c9b28
L_8cafb0:
	b_s L_8caf84
L_8cafb2:
	nop_s
