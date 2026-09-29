/* rm_main_sm__primary_handle_free @ 0x8dcb3c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::primary_handle_free. Handle:0x%x, CB 0x%x
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__store_pending_event, fw_log__emit2, llist__remove, radio_mgr__free_handle
 */
	.section .text.rm_main_sm__primary_handle_free,"ax",@progbits
	.global rm_main_sm__primary_handle_free
rm_main_sm__primary_handle_free:
L_8dcb3c:
	ldb_s r0,[r0,0x7]
	.global fwlog_rm_main_sm_primary_handle_free_Handle_0x
fwlog_rm_main_sm_primary_handle_free_Handle_0x:
L_8dcb3e:
	nop_s
L_8dcb40:
	push_s blink
L_8dcb42:
	bl L_8c02c0
L_8dcb46:
	mov_s r13,r0
L_8dcb48:
	ld_s r0,[r0,0x28]
L_8dcb4a:
	mov_s r14,r1
L_8dcb4c:
	breq_s r0,0,L_8dcb62
L_8dcb4e:
	mov_s r2,0x1015f58
L_8dcb54:
	ld r4,[r14, 0xc]
L_8dcb58:
	mov_s r0,0x8
L_8dcb5a:
	mov_s r1,0x2
L_8dcb5c:
	bl.d L_8edff8
L_8dcb60:
	mov_s r3,r14
	.global L_8dcb62
L_8dcb62:
	add2 r15,r13,0x31
L_8dcb66:
	mov_s r0,r15
L_8dcb68:
	bl.d L_8de4ec
L_8dcb6c:
	mov_s r1,r14
L_8dcb6e:
	ld_s r0,[r13,0x30]
L_8dcb70:
	bl.d L_8d9c0c
L_8dcb74:
	mov_s r1,r14
L_8dcb76:
	ld_s r0,[r15]
L_8dcb78:
	cmp_s r0,0x0
L_8dcb7a:
	mov_s r0,0x1
L_8dcb7c:
	sub_s.ne r0,r0,r0
L_8dcb7e:
	extb.f 0x0,r0
L_8dcb82:
	mov.ne r0,r13
L_8dcb86:
	mov.ne r1,0x5
L_8dcb8a:
	sub_s.ne r2,r2,r2
L_8dcb8c:
	mov.ne r3,r2
L_8dcb90:
	bl.ne.d L_8e20c0
L_8dcb94:
	mov.ne r4,r2
L_8dcb98:
	b L_8c032c
