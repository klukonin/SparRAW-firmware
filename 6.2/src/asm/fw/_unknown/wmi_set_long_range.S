/* wmi_set_long_range @ 0x8ecdcc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_long_range
wmi_set_long_range:
	.global L_8ecdcc
L_8ecdcc:
	push_s blink
L_8ecdce:
	bl.d L_8c01e0
L_8ecdd2:
	mov_s r1,0x1
L_8ecdd4:
	sub_s sp,sp,0x4
L_8ecdd6:
	mov_s r14,r0
L_8ecdd8:
	mov_s r15,r2
L_8ecdda:
	mov_s r0,0x857280
L_8ecde0:
	bl.d L_8c3284
L_8ecde4:
	stb_s r1,[r0,0xe]
L_8ecde6:
	mov_s r1,0x41
L_8ecde8:
	mov_s r2,0x4
L_8ecdea:
	mov_s r13,0x0
L_8ecdec:
	bl.d L_8e5204
L_8ecdf0:
	mov_s r3,r13
L_8ecdf2:
	bl.d L_8c33d0
L_8ecdf6:
	mov_s r0,r14
L_8ecdf8:
	mov_s r1,r0
L_8ecdfa:
	stb_s r13,[r0]
L_8ecdfc:
	st_s r13,[sp,0x0]
L_8ecdfe:
	mov_s r0,r14
L_8ece00:
	mov_s r2,r13
L_8ece02:
	mov_s r3,0x1a05
L_8ece08:
	mov r4,0x4
L_8ece0c:
	mov_s r5,r15
L_8ece0e:
	mov_s r6,r13
L_8ece10:
	bl.d L_8e4fc4
L_8ece14:
	mov_s r7,r13
L_8ece16:
	b.d L_8c024c
L_8ece1a:
	add_s sp,sp,0x4
