/* power_halt__rearm_awake_tsf_irq @ 0x8da800, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_halt__rearm_awake_tsf_irq
power_halt__rearm_awake_tsf_irq:
	.global L_8da800
L_8da800:
	mov_s r1,0x10
L_8da802:
	mov_s r0,0x880b00
L_8da808:
	st_s r1,[r0,0x50]
L_8da80a:
	st_s r1,[r0,0x64]
L_8da80c:
	j_s [blink]
L_8da80e:
	nop_s
