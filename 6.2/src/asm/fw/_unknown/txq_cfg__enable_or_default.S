/* txq_cfg__enable_or_default @ 0x8cc31c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8003a0, 0x8003ac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txq_cfg__enable_or_default
txq_cfg__enable_or_default:
	.global L_8cc31c
L_8cc31c:
	ld_s r0,[gp,0x228]
L_8cc31e:
	mov_s r1,0x1
L_8cc320:
	cmp_s r0,0x0
L_8cc322:
	mov.eq r0,r1
L_8cc326:
	beq_s L_8cc32a
L_8cc328:
	ld_s r0,[gp,0x21c]
	.global L_8cc32a
L_8cc32a:
	j_s.d [blink]
L_8cc32c:
	st.as r0,[gp,0x87]
