/* wmi_set_multi_directed_omnis_config_cmd @ 0x8ece20, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_multi_directed_omnis_config_cmd
wmi_set_multi_directed_omnis_config_cmd:
	.global L_8ece20
L_8ece20:
	push_s blink
L_8ece22:
	bl L_8c01e4
L_8ece26:
	sub_s sp,sp,0x4
L_8ece28:
	mov_s r13,r0
L_8ece2a:
	ldb_s r0,[r1]
L_8ece2c:
	mov_s r14,r2
L_8ece2e:
	cmp_s r0,0x0
L_8ece30:
	mov.le r0,0x1
L_8ece34:
	stb r0,[gp, 0xad]
L_8ece38:
	bl.d L_8c33d0
L_8ece3c:
	mov_s r0,r13
L_8ece3e:
	mov_s r1,r0
L_8ece40:
	mov_s r2,0x0
L_8ece42:
	stb_s r2,[r0]
L_8ece44:
	st_s r2,[sp,0x0]
L_8ece46:
	mov_s r0,r13
L_8ece48:
	mov_s r3,0x1a04
L_8ece4e:
	mov r4,0x4
L_8ece52:
	mov_s r5,r14
L_8ece54:
	mov_s r6,r2
L_8ece56:
	bl.d L_8e4fc4
L_8ece5a:
	mov_s r7,r2
L_8ece5c:
	b.d L_8c0254
L_8ece60:
	add_s sp,sp,0x4
L_8ece62:
	nop_s
