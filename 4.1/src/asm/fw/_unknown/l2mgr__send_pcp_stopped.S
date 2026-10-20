/* l2mgr__send_pcp_stopped @ 0x8f07f4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PCP_STOPPED_EVENTID for midid %d.
 * Зовут его: pcp_stop__flow
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, get_g_8000ac_8c5c9c, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_pcp_stopped,"ax",@progbits
	.global l2mgr__send_pcp_stopped
l2mgr__send_pcp_stopped:
	.global L_8f07f4
L_8f07f4:
	push_s blink
L_8f07f6:
	push_s r13
L_8f07f8:
	mov_s r13,r0
L_8f07fa:
	mov_s r2,0x100d648
L_8f0800:
	mov_s r0,0xb
L_8f0802:
	mov_s r1,0x2
L_8f0804:
	bl.d L_8edfcc
L_8f0808:
	mov_s r3,r13
L_8f080a:
	bl L_8c2b68
L_8f080e:
	mov_s r1,0x1919
L_8f0814:
	mov_s r2,0x0
L_8f0816:
	mov_s r3,r13
L_8f0818:
	mov_s r4,r2
L_8f081a:
	bl.d L_8e0874
L_8f081e:
	mov_s r5,r2
L_8f0820:
	bl.d L_8c5c9c
L_8f0824:
	mov_s r0,0x4
L_8f0826:
	b L_8c033c
L_8f082a:
	nop_s
