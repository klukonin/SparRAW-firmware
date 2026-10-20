/* mid_ctx_pool__init @ 0x8ed514, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid_pool__init
 * Зовёт сам: mem_pool__init
 */
	.section .text.mid_ctx_pool__init,"ax",@progbits
	.global mid_ctx_pool__init
mid_ctx_pool__init:
	.global L_8ed514
L_8ed514:
	push_s blink
L_8ed516:
	mov_s r1,0x842ee8
L_8ed51c:
	sub r0,r1,0x14
L_8ed520:
	mov_s r2,0xc
L_8ed522:
	bl.d L_8c6c70
L_8ed526:
	mov_s r3,0xa
L_8ed528:
	mov_s r1,0x805d98
L_8ed52e:
	mov_s r0,0x0
L_8ed530:
	stw_s r0,[r1]
L_8ed532:
	stw_s r0,[r1,0x2]
L_8ed534:
	stw_s r0,[r1,0x4]
L_8ed536:
	stw_s r0,[r1,0x6]
L_8ed538:
	stw_s r0,[r1,0x8]
L_8ed53a:
	stw_s r0,[r1,0xa]
L_8ed53c:
	stw_s r0,[r1,0xc]
L_8ed53e:
	pop_s blink
L_8ed540:
	j_s [blink]
L_8ed542:
	nop_s
