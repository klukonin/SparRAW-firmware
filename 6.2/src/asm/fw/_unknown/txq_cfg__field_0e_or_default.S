/* txq_cfg__field_0e_or_default @ 0x8cc348, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800204, 0x800390
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txq_cfg__field_0e_or_default
txq_cfg__field_0e_or_default:
	.global L_8cc348
L_8cc348:
	ld_s r0,[gp,0x20c]
L_8cc34a:
	mov_s r1,0x0
L_8cc34c:
	cmp_s r0,0x0
L_8cc34e:
	mov.eq r0,r1
L_8cc352:
	beq_s L_8cc356
L_8cc354:
	ldw_s r0,[gp,0x80]
	.global L_8cc356
L_8cc356:
	j_s.d [blink]
L_8cc358:
	stw.as r0,[gp,0x40]
