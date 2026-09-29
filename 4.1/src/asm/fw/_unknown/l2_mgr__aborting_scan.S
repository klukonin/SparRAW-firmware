/* l2_mgr__aborting_scan @ 0x8e8e70, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::aborting_scan()
 *   l2_mgr::aborting_scan() failed, non-existent devid %d
 *   l2_mgr::aborting_scan() rejected, other scan is ongoing
 * Зовут его: wmi_handler_abort_scan
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, mid_list__by_mid, scan_abort
 */
	.section .text.l2_mgr__aborting_scan,"ax",@progbits
	.global l2_mgr__aborting_scan
l2_mgr__aborting_scan:
	.global L_8e8e70
L_8e8e70:
	push_s blink
L_8e8e72:
	bl L_8c02c4
L_8e8e76:
	bl.d L_8ca1b0
L_8e8e7a:
	mov_s r14,r0
L_8e8e7c:
	mov_s r13,r0
L_8e8e7e:
	mov_s r2,0x100da88
L_8e8e84:
	mov_s r0,0x9
L_8e8e86:
	bl.d L_8edfb0
L_8e8e8a:
	mov_s r1,0x2
L_8e8e8c:
	brne_s r13,0,L_8e8ea2
L_8e8e8e:
	mov_s r2,0x100daa0
L_8e8e94:
	mov_s r0,0x9
L_8e8e96:
	mov_s r1,0x2
L_8e8e98:
	bl.d L_8edfcc
L_8e8e9c:
	mov_s r3,r14
L_8e8e9e:
	mov_s r0,0x0
L_8e8ea0:
	b_s L_8e8ed4
	.global L_8e8ea2
L_8e8ea2:
	mov_s r0,r13
L_8e8ea4:
	add r0,r0,0x234
L_8e8ea8:
	ld_s r2,[r0,0x8]
L_8e8eaa:
	ld_s r2,[r2,0x78]
L_8e8eac:
	mov_s r1,0x0
L_8e8eae:
	brne_s r2,0,L_8e8eb4
L_8e8eb0:
	ld_s r2,[r0,0x70]
L_8e8eb2:
	breq_s r2,0,L_8e8eb6
	.global L_8e8eb4
L_8e8eb4:
	mov_s r1,0x1
	.global L_8e8eb6
L_8e8eb6:
	extb.f 0x0,r1
L_8e8eba:
	bne_s L_8e8ece
L_8e8ebc:
	mov_s r2,0x100dad8
L_8e8ec2:
	mov_s r0,0x9
L_8e8ec4:
	bl.d L_8edfb0
L_8e8ec8:
	mov_s r1,0x2
L_8e8eca:
	mov_s r0,0x0
L_8e8ecc:
	b_s L_8e8ed4
	.global L_8e8ece
L_8e8ece:
	bl L_8eff54
L_8e8ed2:
	mov_s r0,0x1
	.global L_8e8ed4
L_8e8ed4:
	b L_8c0334
