/* sysassert__dump_stack @ 0x8c8220, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Stack dump beginning at 0x%x:
 *   				0x%08x
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1
 */
	.section .text.sysassert__dump_stack,"ax",@progbits
	.global sysassert__dump_stack
sysassert__dump_stack:
	.global L_8c8220
L_8c8220:
	push_s blink
L_8c8222:
	bl.d L_8c02c0
L_8c8226:
	mov_s r1,0x2
L_8c8228:
	mov_s r15,0x807ffc
L_8c822e:
	mov_s r2,0x1001400
L_8c8234:
	mov_s r13,0x0
L_8c8236:
	mov_s r0,r13
L_8c8238:
	bl.d L_8edfcc
L_8c823c:
	mov_s r3,sp
L_8c823e:
	mov_s r14,sp
L_8c8240:
	b_s L_8c8256
	.global L_8c8242
L_8c8242:
	mov_s r2,0x1001420
L_8c8248:
	mov_s r0,0x0
L_8c824a:
	mov_s r1,0x2
L_8c824c:
	bl.d L_8edfcc
L_8c8250:
	ld.ab r3,[r14,0x4]
L_8c8254:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c8256
L_8c8256:
	cmp_s r13,0x10
L_8c8258:
	cmp.cs r14,r15
L_8c825c:
	blo_s L_8c8242
L_8c825e:
	b L_8c032c
L_8c8262:
	nop_s
