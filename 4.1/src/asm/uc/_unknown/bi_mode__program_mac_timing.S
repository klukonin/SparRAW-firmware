/* bi_mode__program_mac_timing @ 0x931b98, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.bi_mode__program_mac_timing,"ax",@progbits
	.global bi_mode__program_mac_timing
bi_mode__program_mac_timing:
	.global L_931b98
L_931b98:
	mov_s r1,0x887000
L_931b9e:
	mov_s r0,0x886d00
L_931ba4:
	st 0x40063,[r0, 0x5c]
L_931bac:
	st 0x10001,[r0, 0x60]
L_931bb4:
	st.as 0x60025,[r1,-0x86]
L_931bbc:
	st.as 0x2000b,[r1,-0x85]
L_931bc4:
	st 0x5300a5,[r0, 0x58]
L_931bcc:
	j_s [blink]
L_931bce:
	nop_s
