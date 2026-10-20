/* conn_msm__on_ntf_lm_started__wait_for_assoc_done @ 0x8de19c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.conn_msm__on_ntf_lm_started__wait_for_assoc_done,"ax",@progbits
	.global conn_msm__on_ntf_lm_started__wait_for_assoc_done
conn_msm__on_ntf_lm_started__wait_for_assoc_done:
L_8de19c:
	mov_s r1,0x1
L_8de19e:
	j_s.d [blink]
L_8de1a0:
	st_s r1,[r0,0x7c]
L_8de1a2:
	nop_s
